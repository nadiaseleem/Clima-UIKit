//
//  NeedsWeather.swift
//  Clima
//
//  Created by Nadia Seleem on 04/02/1442 AH.
//  Copyright © 1442 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(weatherModel:WeatherModel)
}
