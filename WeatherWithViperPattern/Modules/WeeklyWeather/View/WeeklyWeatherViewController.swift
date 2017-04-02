//
//  WeeklyWeatherViewController.swift
//  WeatherWithViperPattern
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import UIKit

protocol WeeklyWeatherViewControllerOutput {
    func fetchWeatherData(totalDay: Int, cityId: Int?)
}

class WeeklyWeatherViewController: BaseViewController {
    
    var presenter: WeeklyWeatherViewControllerOutput!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        WeeklyWeatherAssembly.sharedInstance.config(viewContoller: self)
        
    }
    
    override func viewDidLoad() {
        performFetchWeather()
    }
    
    func performFetchWeather() {
        presenter.fetchWeatherData(totalDay: 7, cityId: 738329)
    }
}
