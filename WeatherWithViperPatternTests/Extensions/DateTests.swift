//
//  DateTests.swift
//  WeatherWithViperPattern
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import XCTest
@testable import WeatherWithViperPattern

class DateTests: XCTestCase {
    
    var referenceDate: Date!
    
    override func setUp() {
        super.setUp()
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        
        var components = DateComponents()
        components.year = 2017
        components.month = 04
        components.day = 30
        components.hour = 23
        components.minute = 59
        components.second = 49
        
        referenceDate = calendar.date(from: components)
    }
    
    func testToDate() {
        
        let dateString = "2017-04-30 23:59:49"
        if let testDate = dateString.toDate() {
            XCTAssertEqual(referenceDate, testDate)
        } else {
            XCTFail()
        }
    }
    
    func testAddWeek() {
        let oneWeekAfter = "2017-05-07 23:59:49".toDate()
        let addWeek = referenceDate.addWeek()
        XCTAssertEqual(oneWeekAfter, addWeek)
    }
    
    func testToShorDate() {
        let shortDateString = "30 Apr 2017"
        let shortDate = referenceDate.toShortString()
        XCTAssertEqual(shortDateString, shortDate)
    }
    
    func testToShorTime() {
        let shortTimeString = "23:59"
        let shortTime = referenceDate.toTimeString()
        XCTAssertEqual(shortTimeString, shortTime)
    }
    
    func testToSqlDate() {
        let sqlDataString = "2017-04-30 23:59:49"
        let sqlDate = referenceDate.toSqlDateString()
        XCTAssertEqual(sqlDataString, sqlDate)
    }
    
    func testToString() {
        let dateString = "2017-04-30 23:59"
        let date = referenceDate.toString()
        XCTAssertEqual(dateString, date)
    }
}
