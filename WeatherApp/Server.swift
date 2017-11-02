//
//  Server.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2017/09/15.
//  Copyright © 2017 Edward Mtshweni. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireSwiftyJSON
import PromiseKit
import CocoaLumberjack
/*
 I'm using this class to call the API server. Usually using the Swagger will eleminate all
 this value key code that i wrote. Going forward the swagger is the best approach for this, so that
 the code will be much easier to maintain
 */

class Server: NSObject
    {
    static let weatherAPIKey = "829d35cfa7c8531ccb8eff874bf1e3bb"
    static let baseUrl = "http://api.openweathermap.org/data/2.5/"
    static let iconURL = "http://openweathermap.org/img/w/"
    
    class func loadWeatherForCurrentLocation(latitude: String, longitude: String) -> Promise<ResponseData>
        {
        let (promise, fulfill, reject) = Promise<ResponseData>.pending()
        let base = self.baseUrl
        let path = "weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(self.weatherAPIKey)"
        let urlPath = base + path
        Alamofire.request(urlPath).responseSwiftyJSON
            {
            response in
            DDLogInfo(response.debugDescription)
            if response.result.isSuccess
                {
                let result = response.result.value
                let responseData = ResponseData()
                if let weatherList = result?["weather"].array
                    {
                    let weather = weatherList.first
                    if let icon = weather?["icon"].rawString()
                        {
                        responseData.iconURL = iconURL + icon + ".png"
                        }
                    }
                let temperature = result?["main"].dictionary
                if let max = temperature?["temp_max"]?.rawString()
                    {
                    responseData.maxTemparature = max
                    }
                if let min = temperature?["temp_min"]?.rawString()
                    {
                    responseData.minTemparature = min
                    }
                if let area = result?["name"].rawString()
                    {
                    responseData.area = area
                    }
                fulfill(responseData)
                }
            else
                {
                if let error = response.error
                    {
                    reject(error)
                    }
                }
            }
        return(promise)
        }
    }

