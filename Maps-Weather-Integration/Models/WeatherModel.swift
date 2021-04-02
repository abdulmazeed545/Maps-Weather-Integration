//
//  WeatherModel.swift
//  Maps-Weather-Integration
//
//  Created by Shaik abdul mazeed on 31/03/21.
//

import Foundation

struct WeatherModel: Codable{
    
    let list: [List]
    
}
struct List : Codable{
    let dt: Int
    let main : Main
    let wind : Wind
    let weather : [Weather]
    let dt_txt: String
    
}
struct Main : Codable{
    
    let temp : Double
    let humidity: Int
    var temperatureString: String {
        return String(format: "%.1f", temp)
    }
}
struct Wind: Codable {
    var speed : Double
    var deg : Int
}
struct Weather : Codable {
    
    var main : String
}
