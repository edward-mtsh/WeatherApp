//
//  WeatherServiceInteractable.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2018/05/07.
//  Copyright © 2018 Edward Mtshweni. All rights reserved.
//

import Foundation
import PromiseKit

protocol WeatherServiceInteractable {
    func loadWeatherForCurrentLocation(latitude: String, longitude: String) -> Promise<Weather>
}
