//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Kullanici on 15.12.2022.
//

import Foundation
struct WeatherData : Codable{
    let name : String
    let main : Main
    let weather : [Weather]
    let wind : Wind
}
struct Main : Codable {
    let temp :Double
}
struct Weather : Codable{
    let description : String
    let main : String
    let id : Int
}
struct Wind : Codable{
    let speed : Float
}
