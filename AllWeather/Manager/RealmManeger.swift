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
    func delete(object : SaveWeather)
}

class DBWeather : RealmManeger {
   

    let realm = try? Realm()
    
    
    func save(present: SaveWeather){
        try! realm?.write {
            realm?.add(present)
        }
    
    }
    
    
    func delete(object : SaveWeather){
        
    }
    
    func obtainWeather() -> [SaveWeather]{
        
        let realm = try! Realm()
        
        let modals = realm.object(ofType: SaveWeather.self, forPrimaryKey: <#_#>)
        
        return [modals]
    }
    
    
    func updateWeather(){
        
    }
}
