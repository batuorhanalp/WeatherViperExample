//
//  WeatherApi.swift
//  WeatherWithViperPattern
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import Foundation
import Alamofire

struct ForecastService {
    
    private static let rootPath = "forecast"
    
    static func get(dayCount: Int, cityId: Int?, completion: @escaping (_ response: ForecastResponse?) -> ()) {
        
        var parameters = [String : AnyObject]()
        
        if let city = cityId {
            parameters = ["id" : city as AnyObject ,
                          "units" : "metric" as AnyObject,
                          "cnt" : dayCount as AnyObject,
                          "lang" : "tr" as AnyObject]
        } else {
            // TODO get location
        }
        
        let router = Router(method: .get, path: ForecastService.rootPath, parameters: parameters)
        do {
            let request = try router.asURLRequest()
            _ = Alamofire.request(request)
                .responseObject(completionHandler: { (response: DataResponse<ForecastResponse>) in
                    
                    print("Weather response: \(response)")
                    
                    if let value = response.result.value {
                        completion(value)
                    } else {
                        completion(nil)
                    }
                })
        } catch let error {
            print("An error occured while fetching weather from API. Error details:\n\(error)")
            completion(nil)
        }
    }
    
}

struct ForecastResponse: ResponseObjectSerializable, ResponseCollectionSerializable {
    
    // TODO add city
    var weathers = [WeatherEntity]()
    // TODO add wind
    
    init?(response: HTTPURLResponse, representation: AnyObject) {
        
        // City info
        let city = representation.value(forKeyPath: "city") as AnyObject
        // TODO city
        
        if let weatherObjects = representation.value(forKeyPath: "list") as? NSArray {
            // First get each weather item
            for weatherObject in weatherObjects {
                
                /*
                 * Temperature and cloud data
                 */
                let object = weatherObject as AnyObject
                // Weather descriptions
                let weatherDatas = object.value(forKeyPath: "weather") as! NSArray
                let weatherData = weatherDatas[0] as AnyObject
                
                // Temperatures 
                let main = object.value(forKeyPath: "main") as AnyObject
                
                // Date
                let date = object.value(forKeyPath: "dt_txt") as! String
                
                // Create weather entity
                let newWeatherEntity = WeatherEntity(
                    currentDescription: weatherData.value(forKeyPath: "description") as! String,
                    currentTemperature: main.value(forKeyPath: "temp") as! Float,
                    date: date.toDate() ?? Date(),
                    icon: weatherData.value(forKeyPath: "icon") as! String,
                    maxTemperature: main.value(forKeyPath: "temp_max") as! Float,
                    minTemperature: main.value(forKeyPath: "temp_min") as! Float)
                
                // Adding to return array
                weathers.append(newWeatherEntity)
                
                
                /*
                 * Wind data
                 */
                // Wind
                let wind = object.value(forKeyPath: "wind") as AnyObject
                // TODO wind
            }
        }
    }
}
