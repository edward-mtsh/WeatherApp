//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2018/05/07.
//  Copyright © 2018 Edward Mtshweni. All rights reserved.
//

import Foundation

class WeatherPresenter: WeatherPresentable {
    var view: WeatherPresenterViewable?
    var interacter: WeatherInteractorable?
    
    func onFetchWeatherSuccess(with weather: Weather) {
        self.view?.showOnSuccess(with: weather)
    }
    
    func onFetchWeatherFailure(with error: Error) {
        self.view?.showOnFailure(with: error)
    }
    
    func loadWeatherForCurrentLocation(latitude: String, longitude: String) {
        self.interacter?.loadWeatherForCurrentLocation(latitude: latitude, longitude: longitude)
    }
}
