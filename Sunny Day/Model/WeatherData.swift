//
//  WeatherData.swift
//  Sunny Day
//
//  Created by Sachin Khanal on 7/20/20.
//  Copyright © 2020 Sachin Khanal. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    var message: String
    var cod: String
    var list: [List]
    
}

struct List: Decodable {
    var id: Int
    var name: String
    var coord: Coord
    var main: Main
    var dt: Int
    var weather: [Weather]
}

struct Coord : Decodable{
    var lat: Double
    var lon: Double
}

struct Main: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Double
}
struct Weather: Decodable {
    var id: Int
}


