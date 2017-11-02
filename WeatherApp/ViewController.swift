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

class ViewController: BaseViewController, CLLocationManagerDelegate
    {
    @IBOutlet private weak var _dateTimeLabel: UILabel!
    @IBOutlet private weak var _maxTemperatureLabel: UILabel!
    @IBOutlet private weak var _minTemperatureLabel: UILabel!
    @IBOutlet private weak var _areaLabel: UILabel!
    @IBOutlet private weak var _weatherImage: UIImageView!
    
    private var _locationManager:CLLocationManager?
    private var _latitude:String?
    private var _longitude:String?
    
    override func viewDidLoad()
        {
        super.viewDidLoad()
        self.initDate()
        }
    
    override func viewDidAppear(_ animated: Bool)
        {
        self.requestAccessToLocation()
        }
    
    func initDate()
        {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let formatedDate = formatter.string(from: date)
        self._dateTimeLabel.text = "Today, \(formatedDate)"
        }
    
    func requestAccessToLocation()
        {
        guard CLLocationManager.locationServicesEnabled() else
            {
            self.showAlert(title: "Access to Location", message:"Access to location is required for the application to function, please go to settings and turn it on and then click the refresh button")
            return
            }
        guard canAccessLocation() else
            {
            return
            }
        self.startUpdatingLocation()
        }
    
    func startUpdatingLocation()
        {
        _locationManager = CLLocationManager()
        _locationManager?.delegate = self
        _locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager?.requestWhenInUseAuthorization()
        _locationManager?.startUpdatingLocation()
        }
    
    func canAccessLocation() -> Bool
        {
        guard CLLocationManager.authorizationStatus() != .denied else
            {
            self.showAlert(title: "Access to Location", message:"Access to location is required for the application to function, please go to settings and allow the app to access your location")
            return(false)
            }
        return(true)
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        {
        let location: CLLocation = locations[locations.count - 1]
        self._latitude =  String(location.coordinate.latitude)
        self._longitude = String(location.coordinate.longitude)
        self._locationManager?.stopUpdatingLocation()
        self.loadWeatherForCurrentLocation()
        }
    
    func loadWeatherForCurrentLocation()
        {
        guard let latitude = self._latitude else
            {
            DDLogError("Error: Latitude is empty")
            return
            }
        guard let longitude = self._longitude else
            {
            DDLogError("Error: Logitude is empty")
            return
            }
        firstly
            {
            _ -> Promise<ResponseData> in
            self.showBusyView()
            return(Server.loadWeatherForCurrentLocation(latitude:latitude, longitude:longitude))
            }
        .then
            {
            responseData -> Void in
            self.pupulateUIView(response: responseData)
            }
        .always
            {
            self.hideBusyView()
            }
        .catch
            {
            error in
            self.showAlert(title: "Weather", message: "Something went wrong, please try again later")
            }
        }
    
    func pupulateUIView(response:ResponseData)
        {
        self._areaLabel.text = response.area
        self._maxTemperatureLabel.text = "max \(response.maxTemparature) °C"
        self._minTemperatureLabel.text = "min \(response.minTemparature) °C"
        if let imageUrl = NSURL(string: response.iconURL) as URL?
            {
            guard let data = NSData(contentsOf:imageUrl) else
                {
                DDLogError("Weather Image icon is empty");
                return
                }
            self._weatherImage.image = UIImage(data:data as Data)
            }
        }
    
    @IBAction func onRefreshTapped(_ sender: Any)
        {
        self.requestAccessToLocation()
        }
    
    override func didReceiveMemoryWarning()
        {
        super.didReceiveMemoryWarning()
        }
    }

