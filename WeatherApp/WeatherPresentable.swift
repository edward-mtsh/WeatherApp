//
//  WeatherPresentable.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2018/05/07.
//  Copyright © 2018 Edward Mtshweni. All rights reserved.
//

import Foundation

protocol WeatherPresentable {
    func loadWeatherForCurrentLocation(latitude: String, longitude: String)
}
