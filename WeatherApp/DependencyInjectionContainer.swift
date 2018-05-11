//
//  DependencyInjectionContainer.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2018/05/10.
//  Copyright © 2018 Edward Mtshweni. All rights reserved.
//

import Foundation
import Swinject

class DependencyInjectionContainer {
    var container: Container? {
        let injection = Container()
        injection.register(WeatherPresenterViewable.self) { r in
        let locationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
        let weatherPresenter = WeatherPresenter()
        let weatherInteractor = WeatherInteractor()
        let weatherServive = WeatherService()
        weatherInteractor.weatherPresenter = weatherPresenter
        weatherInteractor.weatherService = weatherServive
        weatherPresenter.interacter = weatherInteractor
        weatherPresenter.presenter = locationViewController
        return locationViewController
        }
    return injection
    }
}
