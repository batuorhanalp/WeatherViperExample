//
//  WeeklyDataManager.swift
//  WeatherWithViperPattern
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import Foundation

class WeeklyDataManager : NSObject {
    var localData : WeatherCoreData?
    
    // Fetch weekly weather from specific date
    func weeklyWeathers(from firstDate: Date, completion: (([WeatherEntity]) -> Void)!) {

        let lastDate = firstDate.addWeek()
        
        let predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", firstDate as CVarArg, lastDate as CVarArg)
        let sortDescriptors: [NSSortDescriptor] = []
        
        if let db = localData {
            db.fetchWeathersWithPredicate(predicate, sortDescriptors: sortDescriptors, completionBlock: { weatherDatas in
                let weathers = self.fetchFromLocalData(rows: weatherDatas)
                completion(weathers)
            })
        } else {
            completion([WeatherEntity]())
        }
    }
    
    private func fetchFromLocalData(rows: [Weather]) -> [WeatherEntity] {
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
