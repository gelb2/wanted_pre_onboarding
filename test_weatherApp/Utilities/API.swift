//
//  API.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import Foundation

enum API {
    case weatherData(cityWeather)
    
    enum cityWeather {
        case cityName(name: String)
        case cityCoordination(lat: Double, lon: Double)
    }
}


