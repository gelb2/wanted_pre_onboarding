//
//  FirstViewModel.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/06.
//

import Foundation

struct BasicWeatherEntity: Codable {
    var coor: Coordination
    var weather: [Weather]
    var cityName: String //도시이름
    var main: Main
    
    enum CodingKeys: String, CodingKey {
        case coor = "coord"
        case weather = "weather"
        case cityName = "name"
        case main = "main"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        coor = try container.decode(Coordination.self, forKey: .coor)
        weather = try container.decode([Weather].self, forKey: .weather)
        cityName = try container.decode(String.self, forKey: .cityName)
        main = try container.decode(Main.self, forKey: .main)
    }
}



struct Coordination: Codable {
    
    enum CodingKeys: String, CodingKey {
        case lan = "lat"
        case lon = "lon"
    }
    
    var lan: Double
    var lon: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        lan = try container.decode(Double.self, forKey: .lan)
        lon = try container.decode(Double.self, forKey: .lon)
    }
}

struct Weather: Codable {
    var id: Double
    var main: String
    var description: String //날씨 설명
    var icon: String //날씨아이콘
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Double.self, forKey: .id)
        main = try container.decode(String.self, forKey: .main)
        description = try container.decode(String.self, forKey: .description)
        
        let iconName = try container.decode(String.self, forKey: .icon)
        icon = "http://openweathermap.org/img/w/\(iconName).png"
    }
}

struct Main: Codable {
    var temp: Double //현재기온
    var feelsLikeTemp: Double //체감온도
    var tempMin: Double //최저온도
    var tempMax: Double //최고온도
    var pressure: Double //기압
    var humidity: Double //현재습도
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLikeTemp = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        temp = try container.decode(Double.self, forKey: .temp)
        feelsLikeTemp = try container.decode(Double.self, forKey: .feelsLikeTemp)
        tempMin = try container.decode(Double.self, forKey: .tempMin)
        tempMax = try container.decode(Double.self, forKey: .tempMax)
        pressure = try container.decode(Double.self, forKey: .pressure)
        humidity = try container.decode(Double.self, forKey: .humidity)
    }
}
