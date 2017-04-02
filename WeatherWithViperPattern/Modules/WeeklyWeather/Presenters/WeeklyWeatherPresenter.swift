//
//  WeeklyWeatherPresenter.swift
//  WeatherWithViperPattern
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import UIKit

protocol WeeklyWeatherPresenterInput: WeeklyWeatherViewControllerOutput {
    func fetchWeatherData(totalDay: Int, cityId: Int?)
}

class WeeklyWeatherPresenter: WeeklyWeatherPresenterInput {
    
    var interactor: WeeklyWeatherInteractorInput!
    
    func fetchWeatherData(totalDay: Int, cityId: Int?) {
        interactor.fetchWeeklyWeatherFromDataManager(totalDay: totalDay, cityId: cityId)
    }
}
