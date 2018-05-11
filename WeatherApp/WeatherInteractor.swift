//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2018/05/07.
//  Copyright © 2018 Edward Mtshweni. All rights reserved.
//

import Foundation
import PromiseKit

class WeatherInteractor: WeatherInteractorable {
    var weatherPresenter: WeatherPresenterInteractable?
    var weatherService: WeatherServiceInteractable?
    
    func loadWeatherForCurrentLocation(latitude: String, longitude: String) {
        firstly {
            _ -> Promise<Weather> in
            return(weatherService?.loadWeatherForCurrentLocation(latitude:latitude, longitude:longitude))!
        } .then {
            weather -> Void in
            self.weatherPresenter?.onFetchWeatherSuccess(with: weather)
        } .catch {
            error in
            let failure = error as! Error
            self.weatherPresenter?.onFetchWeatherFailure(with: failure)
        }
    }
}
