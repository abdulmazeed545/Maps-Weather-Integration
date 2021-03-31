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
    
}
struct Main : Codable{
    
    let temp : Double
    let humidity: Int
}
struct Wind: Codable {
    var speed : Double
    var deg : Int
}
