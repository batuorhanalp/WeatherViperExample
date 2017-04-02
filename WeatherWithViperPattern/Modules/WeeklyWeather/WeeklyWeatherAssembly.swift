//
//  WeeklyWeatherAssembly.swift
//  WeatherWithViperPattern
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import Foundation

class WeeklyWeatherAssembly {
    
    static let sharedInstance = WeeklyWeatherAssembly()
    
    func config(viewContoller: WeeklyWeatherViewController) {
        let dataManager = WeeklyDataManager()
        let interactor = WeeklyWeatherInteractor()
        let presenter = WeeklyWeatherPresenter()
        
        viewContoller.presenter = presenter
        presenter.interactor = interactor
        interactor.ApiDataManager = dataManager
    }
}
