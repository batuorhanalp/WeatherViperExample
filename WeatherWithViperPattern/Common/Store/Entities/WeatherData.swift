//
//  WeatherEntity.swift
//  WeatherWithViperPattern
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import Foundation
import CoreData

final class WeatherData: NSManagedObject {
    @NSManaged var currentDescription: String
    @NSManaged var currentTemperature: Float
    @NSManaged var date: Date
    @NSManaged var icon: String
    @NSManaged var maxTemperature: Float
    @NSManaged var minTemperature: Float
}

final class WeatherCoreData: LocalData {
    
    func fetchWeathersWithPredicate(_ predicate: NSPredicate, sortDescriptors: [NSSortDescriptor], completionBlock: (([WeatherData]) -> Void)!) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>  = NSFetchRequest(entityName: "Weather")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        managedObjectContext.perform {
            let queryResults = try? self.managedObjectContext.fetch(fetchRequest)
            let managedResults = queryResults! as! [WeatherData]
            completionBlock(managedResults)
        }
    }
    
    func newWeather() -> WeatherData {
        let newWeather = NSEntityDescription.insertNewObject(forEntityName: "Weather", into: managedObjectContext) as! WeatherData
        
        return newWeather
    }
    
}
