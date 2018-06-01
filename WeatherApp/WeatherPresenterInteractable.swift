//
//  WeatherPresenterInteractable.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2018/05/07.
//  Copyright © 2018 Edward Mtshweni. All rights reserved.
//

import Foundation

protocol WeatherPresenterInteractable {
    func onFetchWeatherSuccess(with showcaseApps: Weather)
    func onFetchWeatherFailure(with error: Error)
}
