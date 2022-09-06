//
//  FirstViewModel.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/06.
//

import Foundation

struct FirstViewModel: Decodable {
    var coor: Coordination
    var weather: [Weather]
    var cityName: String
}

struct Coordination: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case lan = "lan"
        case lon = "lon"
    }
    
    var lan: Double?
    var lon: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        lan = (try? container.decode(Double.self, forKey: .lan)) ?? 0.1111111
        lon = try container.decode(Double.self, forKey: .lon)
    }
}

struct Weather: Decodable {
    var id: Double
    var main: String
    var description: String
    var icon: String
    
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
        
        //TODO: http://openweathermap.org/img/w/10d.png
        icon = try container.decode(String.self, forKey: .icon)
    }
}
