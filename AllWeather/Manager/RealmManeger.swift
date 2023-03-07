//
//  RealmManeger.swift
//  AllWeather
//
//  Created by Alex Grazhdan on 06.03.2023.
//

import Foundation
import RealmSwift

protocol RealmManeger {
    func save(present: SaveWeather)
//    func obtainWeather() -> Object
    func delete(object : Object)
}

class DBWeather : RealmManeger {
   
fileprivate lazy var mainRealm = try? Realm()
    var arrayCurrentWeather: [SaveWeather] = []

    func save(present: SaveWeather){
        
        try! mainRealm?.write {
            mainRealm?.add(present)
        }
    
    }
    
    
    func delete(object : Object){
        
        try! mainRealm?.write {
            mainRealm?.delete(object)
        }
    }
    
//    func obtainWeather() -> Object{
//
//        let modals = mainRealm?.objects(SaveWeather.self)
////                for weater in modals {
////                    self.arrayCurrentWeather.append(weater)
////                }
//        return Array<SaveWeather>
//    }
    
    
    func updateWeather(){
        
    }
}
