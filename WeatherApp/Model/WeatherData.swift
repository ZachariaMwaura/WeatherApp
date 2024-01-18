//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Zach Mwaura on 1/16/24.
//

import Foundation

struct WeatherData: Codable { // decodable from JSON
    let name: String
    let main: Main
    let weather: [Weather] // an array
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
