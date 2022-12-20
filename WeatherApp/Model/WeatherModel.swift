//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Kullanici on 16.12.2022.
//

import Foundation
struct WeatherModel {
    let conditionID : Int
    let cityName : String
    let temperature : Double
    var condition : String {
        switch conditionID {
        case 801 ... 804:
            return "cloud"
        case 800 :
            return "sun.max"
        case 600...622 :
            return "snow"
        case 500...531 :
            return "cloud.rain"
        case 300...321 :
            return "cloud.drizzle"
        case 200...232 :
            return "cloud.bolt.rain"
        case 700...781:
            return "cloud.fog"
        default:
            return "error"
        }
     
    }
    var temperatureString : String {
       return String(format: "%.1f", temperature)
    }
//    func getConditionName(weatherID : Int) -> String {
//        switch weatherID {
//        case 801 ... 804:
//            return "cloud"
//        case 800 :
//            return "sun.max"
//        case 600...622 :
//            return "snow"
//        case 500...531 :
//            return "cloud.rain"
//        case 300...321 :
//            return "cloud.drizzle"
//        case 200...232 :
//            return "cloud.bolt.rain"
//        case 700...781:
//            return "cloud.fog"
//        default:
//            ""
//        }
//        return ""
//    }
}
