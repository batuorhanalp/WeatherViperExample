//
//  WeatherEntity.swift
//  WeatherWithViperPattern
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import Foundation
import CoreData

final class WeatherCoreData: LocalData {
    
    func fetchWeathersWithPredicate(_ predicate: NSPredicate, sortDescriptors: [NSSortDescriptor], completionBlock: (([Weather]) -> Void)!) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>  = NSFetchRequest(entityName: "Weather")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        managedObjectContext.perform {
            let queryResults = try? self.managedObjectContext.fetch(fetchRequest)
            let managedResults = queryResults! as! [Weather]
            completionBlock(managedResults)
        }
    }
    
    func newWeather() -> Weather {
        let newWeather = NSEntityDescription.insertNewObject(forEntityName: "Weather", into: managedObjectContext) as! Weather
        
        return newWeather
    }
    
    func newWeather(from entity: WeatherEntity) -> Weather {
        let newWeather = self.newWeather()
        
        newWeather.currentDescription = entity.currentDescription
        newWeather.currentTemperature = entity.currentTemperature
        newWeather.date = entity.date as NSDate? ?? NSDate()
        newWeather.icon = entity.icon
        newWeather.maxTemperature = entity.maxTemperature
        newWeather.minTemperature = entity.minTemperature
        
        return newWeather
    }
    
}
