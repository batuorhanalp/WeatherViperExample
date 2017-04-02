//
//  WeatherWithViperPatternTests.swift
//  WeatherWithViperPatternTests
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import XCTest
@testable import WeatherWithViperPattern

class WeatherTests: XCTestCase {
    
    var db = WeatherCoreData()
    var dataManager = WeeklyDataManager()
    var weatherEntity = WeatherEntity(currentDescription: "Test description",
                                      currentTemperature: 15,
                                      date: Date(),
                                      icon: "icon",
                                      maxTemperature: 20,
                                      minTemperature: 10)
    
    override func setUp() {
        super.setUp()
        
        dataManager.localData = db
    }
    
    func testNewWeather() {
        
        let context = db.newWeather().managedObjectContext
        
        XCTAssert(context != nil)
    }
    
    func testNewWeatherWithEntity() {
        
        let newWeather = db.newWeather(from: weatherEntity)
        
        XCTAssertEqual(newWeather.currentDescription, weatherEntity.currentDescription)
        XCTAssertEqual(newWeather.currentTemperature, weatherEntity.currentTemperature)
        XCTAssertEqual(newWeather.date as! Date, weatherEntity.date)
        XCTAssertEqual(newWeather.icon, weatherEntity.icon)
        XCTAssertEqual(newWeather.maxTemperature, weatherEntity.maxTemperature)
        XCTAssertEqual(newWeather.minTemperature, weatherEntity.minTemperature)
        
    }
    
    func testFetchData() {
        dataManager.weeklyWeathers(from: Date()) { (weathers) in
            XCTAssertEqual(weathers.count, 0)
        }
    }
}
