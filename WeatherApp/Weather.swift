//
//  Weather.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2017/09/15.
//  Copyright © 2017 Edward Mtshweni. All rights reserved.
//

import Foundation
import CocoaLumberjack

class Weather
    {
    var minimumTemperature:Double
    var maximumTemperature:Double
    var area:String
    var iconURL:String
    
    init?(jsonDictionary: [String: Any])
        {
        guard let main = jsonDictionary["main"] as? [String: Any],
              let maximumTemperature = main["temp_max"] as? Double,
              let minimumTemperature = main["temp_min"] as? Double,
              let weather = (jsonDictionary["weather"] as? [[String: Any]])?.first,
              let iconURL = weather["icon"] as? String,
              let name = jsonDictionary["name"] as? String else
            {
            DDLogError("Error: Invalid json dictionary")
            return(nil)
            }
        self.minimumTemperature = minimumTemperature
        self.maximumTemperature = maximumTemperature
        self.iconURL = iconURL
        self.area = name
        }
    }
