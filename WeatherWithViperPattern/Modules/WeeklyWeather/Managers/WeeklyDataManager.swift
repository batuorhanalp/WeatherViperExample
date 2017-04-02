//
//  WeeklyDataManager.swift
//  WeatherWithViperPattern
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import Foundation

protocol WeeklyDataApiProtocol {
    func weeklyWeather(dayCount: Int, cityId: Int?, completion: ((ForecastResponse?) -> Void)!)
}

protocol WeeklyDataLocalProtocol {
    func weeklyWeather(from firstDate: Date, completion: (([WeatherEntity]) -> Void)!)
}

class WeeklyDataManager : NSObject, WeeklyDataApiProtocol, WeeklyDataLocalProtocol {
    var localData : WeatherCoreData?
    
    // Fetch weekly weather from API
    func weeklyWeather(dayCount: Int, cityId: Int?, completion: ((ForecastResponse?) -> Void)!) {
        ForecastService.get(dayCount: dayCount, cityId: cityId) { (response) in
            completion(response)
        }
    }
    
    // Fetch weekly weather from specific date from local
    func weeklyWeather(from firstDate: Date, completion: (([WeatherEntity]) -> Void)!) {

        let lastDate = firstDate.addWeek()
        
        let predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", firstDate as CVarArg, lastDate as CVarArg)
        let sortDescriptors: [NSSortDescriptor] = []
        
        if let db = localData {
            db.fetchWeathersWithPredicate(predicate, sortDescriptors: sortDescriptors, completionBlock: { weatherDatas in
                let weathers = self.fetchFrom(rows: weatherDatas)
                completion(weathers)
            })
        } else {
            completion([WeatherEntity]())
        }
    }
    
    // Save forecast response to CoreData
    func saveWeather(fromForecast forecast: ForecastResponse) {
        // TODO City
        
        // TODO Wind
        
        let weatherData = WeatherCoreData()
        for weather in forecast.weathers {
            let data = weatherData.newWeather(from: weather)
            do {
                try data.managedObjectContext?.save()
            } catch let error {
                print("An error occured while saving weather data. Error details:\n\(error)")
            }
        }
    }
    
    private func fetchFrom(rows: [Weather]) -> [WeatherEntity] {
        var weathers : [WeatherEntity] = []
        
        for row in rows {
            let weather = WeatherEntity(currentDescription: row.currentDescription ?? "",
                                        currentTemperature: row.currentTemperature,
                                        date: row.date as! Date,
                                        icon: row.icon!,
                                        maxTemperature: row.maxTemperature,
                                        minTemperature: row.minTemperature)
            weathers.append(weather)
        }
        
        return weathers
    }
}
