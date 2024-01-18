//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Zach Mwaura on 1/16/24.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    /*
         var property: datatype {
            output
         }
     */
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    //computed property
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.fill"
        default:
            return "error"
        }
    }
    
//    func getConditionName(weatherId: Int) -> String {
//        switch weatherId {
//        case 200...232:
//            return "cloud.bolt.rain"
//        case 300...321:
//            return "cloud.drizzle"
//        case 500...531:
//            return "cloud.rain"
//        case 600...622:
//            return "snow"
//        case 700...781:
//            return "cloud.fog"
//        case 800:
//            return "sun.max"
//        case 801...804:
//            return "cloud.fill"
//        default:
//            return "error"
//        }
//    }
}
