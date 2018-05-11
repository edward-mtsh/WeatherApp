//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2018/05/07.
//  Copyright © 2018 Edward Mtshweni. All rights reserved.
//

import Foundation

class WeatherPresenter: WeatherPresentable {
    var presenter: WeatherPresenterViewable?
    var interacter: WeatherInteractorable?
    
    func loadWeatherForCurrentLocation(latitude: String, longitude: String) {
        self.interacter?.loadWeatherForCurrentLocation(latitude: latitude, longitude: longitude)
    }
}

extension WeatherPresenter: WeatherPresenterInteractable {
    
    func onFetchWeatherSuccess(with weather: Weather) {
       // self.weatherPresenterViewable
        self.presenter?.showOnSuccess(with: weather)
    }
    
    func onFetchWeatherFailure(with error: Error) {
        self.presenter?.showOnFailure(with: error)
    }
}
