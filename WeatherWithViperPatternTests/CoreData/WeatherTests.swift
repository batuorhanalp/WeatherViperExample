//
//  WeatherWithViperPatternTests.swift
//  WeatherWithViperPatternTests
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import XCTest
import SwiftDate
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
    
    func testFetchFromCoreData() {
        
        let dataExpectation = expectation(description: "Fetching from API")
        var data: [WeatherEntity]?
        
        dataManager.weeklyWeather(from: Date()) { (weathers) in
            data = weathers
            dataExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3) { (error) in
            XCTAssert(error == nil)
            XCTAssert(data != nil)
            XCTAssertEqual(data?.count, 0)
        }
    }
    
    func testFetchFromApi() {

        let dataExpectation = expectation(description: "Fetching from API")
        var data: ForecastResponse?
        
        dataManager.weeklyWeather(dayCount: 7, cityId: 738329) { (response) in
            data = response
            dataExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3) { (error) in
            XCTAssert(error == nil)
            XCTAssert(data != nil)
            XCTAssert(data?.weathers.count == 7)
        }
    }
    
    func testFailFetchApi() {
        let dataExpectation = expectation(description: "Fetching from API")
        var data: ForecastResponse?
        
        dataManager.weeklyWeather(dayCount: 0, cityId: 0) { (response) in
            data = response
            dataExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3) { (error) in
            XCTAssert(error == nil)
            XCTAssert(data != nil)
            XCTAssert(data?.weathers.count == 0)
        }
    }
    
    //func testSaveResponse() {
        //let response = ForecastResponse(response: <#T##HTTPURLResponse#>, representation: <#T##AnyObject#>)
    //}
}
