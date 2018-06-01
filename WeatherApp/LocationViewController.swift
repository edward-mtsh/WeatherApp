//
//  ViewController.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2017/09/15.
//  Copyright © 2017 Edward Mtshweni. All rights reserved.
//

import UIKit
import CoreLocation
import Crashlytics
import PromiseKit
import CocoaLumberjack

class LocationViewController: BaseViewController, CLLocationManagerDelegate {
    @IBOutlet private weak var _dateTimeLabel: UILabel!
    @IBOutlet private weak var _maxTemperatureLabel: UILabel!
    @IBOutlet private weak var _minTemperatureLabel: UILabel!
    @IBOutlet private weak var _areaLabel: UILabel!
    @IBOutlet private weak var _weatherImage: UIImageView!
    
    private var _locationManager:CLLocationManager?
    private var _latitude:String?
    private var _longitude:String?
    private var presenter: WeatherPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.injectDependencies()
        self.initDate()
    }
    
    func injectDependencies() {
        let dependancyContainer = DependencyContainer.container()
        self.presenter = dependancyContainer.resolve(WeatherPresentable.self)
        self.presenter?.view = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.requestAccessToLocation()
    }
    
    func initDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let formatedDate = formatter.string(from: date)
        self._dateTimeLabel.text = "Today, \(formatedDate)"
    }
    
    func requestAccessToLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
            self.messageLibrary.presentAlert(controller: self, title: "Access to Location", message: .locationAccess)
            return
        }
        guard canAccessLocation() else {
            return
        }
        self.startUpdatingLocation()
    }
    
    func startUpdatingLocation(){
        _locationManager = CLLocationManager()
        _locationManager?.delegate = self
        _locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager?.requestWhenInUseAuthorization()
        _locationManager?.startUpdatingLocation()
    }
    
    func canAccessLocation() -> Bool {
        guard CLLocationManager.authorizationStatus() != .denied else {
            messageLibrary.presentAlert(controller: self, title: "Access to Location", message: .locationAccess)
            return(false)
        }
        return(true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[locations.count - 1]
        self._latitude =  String(location.coordinate.latitude)
        self._longitude = String(location.coordinate.longitude)
        self._locationManager?.stopUpdatingLocation()
        guard let latitude = self._latitude else {
            DDLogError("Error: Latitude is empty")
            return
        }
        guard let longitude = self._longitude else {
            DDLogError("Error: Logitude is empty")
            return
        }
        self.showBusyView()
        self.presenter?.loadWeatherForCurrentLocation(latitude: latitude, longitude: longitude)
    }
    
    func pupulateUIView(weather:Weather) {
        self._areaLabel.text = weather.area
        self._maxTemperatureLabel.text = "max \(weather.maximumTemperature) °C"
        self._minTemperatureLabel.text = "min \(weather.minimumTemperature) °C"
        let iconURL = "http://openweathermap.org/img/w/"
        let iconUrl = "\(iconURL)\(weather.iconURL).png"
        if let imageUrl = NSURL(string: iconUrl) as URL? {
            guard let data = NSData(contentsOf:imageUrl) else {
                DDLogError("Weather Image icon is empty");
                return
            }
        self._weatherImage.image = UIImage(data:data as Data)
        }
    }
    
    @IBAction func onRefreshTapped(_ sender: Any) {
        self.requestAccessToLocation()
    }
}

extension LocationViewController: WeatherPresenterViewable {

    func showOnSuccess(with weather: Weather) {
        self.hideBusyView()
        self.pupulateUIView(weather: weather)
    }
    
    func showOnFailure(with error: Error) {
        self.hideBusyView()
        self.messageLibrary.presentAlert(controller: self, title: "Weather", message: .serverError)
    }
}

