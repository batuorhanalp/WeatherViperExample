//
//  WeatherEntity.swift
//  WeatherWithViperPattern
//
//  Created by Batu Orhanalp on 02/04/2017.
//  Copyright © 2017 Batu Orhanalp. All rights reserved.
//

import Foundation
import CoreData

final class WeatherEntity: NSManagedObject {
    @NSManaged var cityId: Int
    @NSManaged var date: Date
    @NSManaged var degree: Float
}
