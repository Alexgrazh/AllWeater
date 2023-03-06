//
//  GeofanceManager.swift
//  AllWeather
//
//  Created by Alex Grazhdan on 05.01.2023.
//

import Alamofire
import CoreLocation


class GeofanceManager :NSObject, CLLocationManagerDelegate{
    
    private var currentLocation : CLLocation?
    private let locationManager = CLLocationManager()
    
    
    var modals : [List] = []
  
    func setupLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !locations.isEmpty , currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
        }
    }
    
    func requestWeatehrForLocation(lat: Double, lon: Double){
        
//        guard let currentLocation = currentLocation else {
//            return
//        }
//        let lon = currentLocation.coordinate.longitude
//        let lat = currentLocation.coordinate.latitude
        
        print("\(lon) | \(lat)")
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=246aae878eba3bb799b8cb312a03ed5f"

                AF.request(url).responseJSON { response in
                    guard let responseData = response.data else {return}
                   let dataString = String(data: responseData, encoding: .utf8) ?? ""
                    print(dataString)
                    do {
                        let data = try JSONDecoder().decode(WeatherResponse.self, from: response.data!)
                        self.modals = data.list

                    }catch{
                    print("error \(error)")
                }
            }
        
        
    }
    
    
}
