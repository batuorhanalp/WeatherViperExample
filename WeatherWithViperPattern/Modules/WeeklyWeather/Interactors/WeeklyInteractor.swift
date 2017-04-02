//
//  WeeklyInteractor.swift
//  WeatherWithViperPattern
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import Foundation

protocol WeeklyWeatherInteractorInput {
    func fetchWeeklyWeatherFromDataManager(totalDay: Int, cityId: Int?)
}

class WeeklyWeatherInteractor: WeeklyWeatherInteractorInput {
    
    var ApiDataManager: WeeklyDataApiProtocol!
    
    /* 
     * TODO - Interactor should get location if there is no city info
     */
    func fetchWeeklyWeatherFromDataManager(totalDay: Int, cityId: Int?) {
        ApiDataManager.weeklyWeather(dayCount: totalDay, cityId: cityId) { (response) in
            if let data = response {
                // TODO
            } else {
                // TODO
            }
        }
    }
    
}
