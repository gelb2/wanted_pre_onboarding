//
//  DetailDataSourceModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/09.
//

import Foundation

class DetailDataSourceModel {
    
    //input
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
    
    //output
    var presentTempString: String {
        return String(describing: presentTemp).addTempratureSign()
    }
    var feelsLikeTempString: String {
        return String(describing: feelsLikeTemp).addTempratureSign()
    }
    var presentHumidString: String {
        return String(describing: presentHumid).addHumiditySign()
    }
    var min_TempString: String {
        return String(describing: min_Temp).addTempratureSign()
    }
    var max_TempString: String {
        return String(describing: max_Temp).addTempratureSign()
    }
    var pressureString: String {
        return String(describing: pressure).addPressureSign()
    }
    var windSpeedString: String {
        return String(describing: windSpeed).addWindSpeedSign()
    }
    
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
