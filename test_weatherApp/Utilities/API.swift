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
    
    //TODO: API Enum에서 자동으로 리턴 가능하게끔 개선
    //쿼리스트링 관련 처리 다른 클래스로 이동 혹은 개선
    var url: URL? {
        switch self {
        case .weatherData(.cityName(let name)):
            let baseURLString = APIURLAddressSet.baseURL.urlString
            let cityNameString = APIURLAddressSet.cityName(name: name).urlString
            let appIDString = APIURLAddressSet.appID.urlString
            return URL(string: baseURLString + cityNameString + appIDString)
        case .weatherData(.cityCoordination(lat: let lat, lon: let lon)):
            return nil
        }
    }
    
    //TODO: baseURL 리턴 더 괜찮은 방법으로 리팩토링
    var baseURLSet: URLComponents? {
        return URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
    }
    
    var appIDSet: URLQueryItem {
        return URLQueryItem(name: "appid", value: "7f1a9a7368d6f22c077f8bef8d7a5200")
    }
    
    //TODO: 쿼리아이템 리턴 더 괜찮은 방법으로 리팩토링
    var querySet: URLQueryItem {
        switch self {
        case .weatherData(.cityName(let name)):
            return URLQueryItem(name: "q", value: name)
        case .weatherData(.cityCoordination(lat: let lat, lon: let lon)):
            return URLQueryItem(name: "q", value: String(lat))
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .weatherData(.cityName(_)):
            return HTTPMethod.GET
        case .weatherData(.cityCoordination(_, _)):
            return HTTPMethod.GET
        }
    }
}

//TODO: API Enum에서 자동으로 리턴 가능하게끔 개선
//쿼리스트링 관련 처리 다른 클래스로 이동 혹은 개선
enum APIURLAddressSet {
    case baseURL
    case appID
    case cityName(name: String)
    
    var urlString: String {
        switch self {
        case .baseURL:
            return "https://api.openweathermap.org/data/2.5/"
        case .appID:
            return "&appid=7f1a9a7368d6f22c077f8bef8d7a5200"
        case .cityName(let name):
            return "weather?q=\(name)"
        }
    }
}
