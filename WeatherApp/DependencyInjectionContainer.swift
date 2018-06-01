//
//  DependencyInjectionContainer.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2018/05/10.
//  Copyright © 2018 Edward Mtshweni. All rights reserved.
//

import Foundation
import Swinject

struct DependencyContainer {
    
    static func container() -> Container {
        let container = Container()
        
        container.register(WeatherPresentable.self) { r in
            let weatherPresenter = WeatherPresenter()
            let weatherInteractor = WeatherInteractor()
            let weatherServive = WeatherService()
            weatherInteractor.weatherPresenter = weatherPresenter
            weatherInteractor.weatherService = weatherServive
            weatherPresenter.interacter = weatherInteractor
            return weatherPresenter
        }
        return container
    }
}
