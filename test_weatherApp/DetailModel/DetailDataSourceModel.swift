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
        let output = "현재온도" + "\n" + String(describing: presentTemp).addTempratureSign()
        return output
    }
    var feelsLikeTempString: String {
        let output = "체감온도" + "\n" + String(describing: feelsLikeTemp).addTempratureSign()
        return output
    }
    var presentHumidString: String {
        let output = "현재습도" + "\n" + String(describing: presentHumid).addHumiditySign()
        return output
    }
    var min_TempString: String {
        let output = "최저온도" + "\n" + String(describing: min_Temp).addTempratureSign()
        return output
    }
    var max_TempString: String {
        let output = "최고온도" + "\n" + String(describing: max_Temp).addTempratureSign()
        return output
    }
    var pressureString: String {
        let output = "기압" + "\n" + String(describing: pressure).addPressureSign()
        return output
    }
    var windSpeedString: String {
        let output = "풍속" + "\n" + String(describing: windSpeed).addWindSpeedSign()
        return output
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
