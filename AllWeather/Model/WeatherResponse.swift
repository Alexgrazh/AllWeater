//
//  AllData.swift
//  AllWeather
//
//  Created by Alex Grazhdan on 06.01.2023.
//

import UIKit


// MARK: - WeatherAPIWeek
struct WeatherResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dtTxt: String
    let rain, snow: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain, snow
    }
    
//    var conditionImage: UIImage {
//        switch main{
//        case weather[0].i:
//            return (#imageLiteral(resourceName: "clouds"))
//        default:
//            return (#imageLiteral(resourceName: "сонце"))
//        }
//    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: MainEnum
    let description, icon: String
    
    var conditionImage: UIImage {
        switch main{
        case MainEnum(rawValue: "Clouds")!:
            return (#imageLiteral(resourceName: "clouds"))
        case MainEnum(rawValue: "Rain")!:
            return (#imageLiteral(resourceName: "rain"))
        case MainEnum(rawValue: "Snow")!:
            return (#imageLiteral(resourceName: "snow"))
        default:
            return (#imageLiteral(resourceName: "сонце"))
        }
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}










//struct WeatherResponse: Codable {
//    let coord: Coord
//    let weather: [Weather]
//    let main: Main
//    let wind: Wind
//    let sys: Sys
//    let name: String
//    let dt: Int
//}
//
//struct Coord: Codable {
//    let lon: Double
//    let lat: Double
//}
//
//struct Weather: Codable {
//    let id: Int
//    let main: String
//    let description: String
//    let icon: String
//
//    var conditionImage: UIImage {
//        switch main{
//        case "Clouds":
//            return (#imageLiteral(resourceName: "cloudy"))
//        default:
//            return (#imageLiteral(resourceName: "сонце"))
//        }
//    }
//}
//
//struct Main: Codable {
//    let temp: Double
//    let feels_like: Double
//    let temp_min: Double
//    let temp_max: Double
//    let pressure: Int
//    let humidity: Int
//}
//
//struct Wind: Codable {
//    let speed: Double
//    let deg: Int
//}
//
//struct Sys: Codable {
//    let country: String
//    let sunrise: Int
//    let sunset: Int
//}

