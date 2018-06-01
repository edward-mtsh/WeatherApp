//
//  WeatherPresentable.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2018/05/07.
//  Copyright © 2018 Edward Mtshweni. All rights reserved.
//

import Foundation

protocol WeatherPresentable {
    var view: WeatherPresenterViewable?{get set}
    func onFetchWeatherSuccess(with showcaseApps: Weather)
    func onFetchWeatherFailure(with error: Error)
    func loadWeatherForCurrentLocation(latitude: String, longitude: String)
}
