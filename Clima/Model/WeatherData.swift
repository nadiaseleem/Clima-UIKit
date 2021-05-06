//
//  WeatherData.swift
//  Clima
//
//  Created by Nadia Seleem on 01/02/1442 AH.
//

import Foundation

struct WeatherData:Codable{
    let main:Main
    let weather: [Weather]
    let name:String

}

struct Main:Codable{
    let temp:Double

}

struct Weather:Codable{
    let id:Int
}




