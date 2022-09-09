//
//  DetailDataSourceModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/09.
//

import Foundation

class DetailDataSourceModel {
    var cityName: String
    var icon: String
    var presentTemp: Double
    var feelsLikeTemp: Double
    var presentHumid: Double
    var min_Temp: Double
    var max_Temp: Double
    var pressure: Double
    var windSpeed: Double
    var weatherDesc: String
    
    init() {
        self.cityName = ""
        self.icon = ""
        self.presentTemp = 0.0
        self.feelsLikeTemp = 0.0
        self.presentHumid = 0.0
        self.min_Temp = 0.0
        self.max_Temp = 0.0
        self.pressure = 0.0
        self.windSpeed = 0.0
        self.weatherDesc = ""
    }
}
