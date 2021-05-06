//
//  WeatherModel.swift
//  Clima
//
//  Created by Nadia Seleem on 04/02/1442 AH.
//

import Foundation
struct WeatherModel {
    let conditionId:Int
    let temperature:Double
    let cityName:String
    var temperatureString:String{
        return String(format: "%0.1f", temperature)
    }
    var conditionName: String{
        let stringId = String(conditionId)
        switch stringId.first {
        case "2":
            return "cloud.bolt"
        case "3":
            return "cloud.drizzle"
        case "5":
            return "cloud.rain"
        case "6":
            return "snow"
        case "7":
            return "cloud.fog"
        case "8":
            if stringId == "800"{
                return "sun.max"}
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    
}
