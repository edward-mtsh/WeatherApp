//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2018/05/07.
//  Copyright © 2018 Edward Mtshweni. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireSwiftyJSON
import PromiseKit
import CocoaLumberjack

class WeatherService: WeatherServiceInteractable {
    let weatherAPIKey = "829d35cfa7c8531ccb8eff874bf1e3bb"
    let baseUrl = "http://api.openweathermap.org/data/2.5/"
    let iconURL = "http://openweathermap.org/img/w/"
    
    func loadWeatherForCurrentLocation(latitude: String, longitude: String) -> Promise<Weather> {
        let (promise, fulfil, reject) = Promise<Weather>.pending()
        let base = self.baseUrl
        let path = "weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(self.weatherAPIKey)"
        let urlPath = base + path
        
        Alamofire.request(urlPath).responseJSON { (response) in
            if response.result.isSuccess {
                if let result = response.value as? [String: Any] {
                    let weather = Weather(jsonDictionary: result)
                    fulfil(weather!)
                }
            } else {
                if let error = response.error {
                    reject(error)
                }
            }
        }
        return promise
    }
}
