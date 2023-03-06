//
//  SaveWeather.swift
//  AllWeather
//
//  Created by Alex Grazhdan on 04.03.2023.
//

import Foundation
import RealmSwift

class SaveWeather : Object {
    @Persisted(primaryKey: true) var weatherCondition : String?
    @Persisted var currentWeather : Int
    @Persisted var tempMax : Int
    @Persisted var humidity : Int
    @Persisted var precipitation : Int
    @Persisted var wind : Int
 
}
