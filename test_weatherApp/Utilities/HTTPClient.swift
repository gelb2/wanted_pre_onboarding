//
//  HTTPClient.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/06.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

enum MINEType: String {
    case JSON = "application/json"
}

enum HTTPHeaders: String {
    case contentType = "Content-Type"
}

enum HTTPError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL, iosDevloperIsStupid
}

//https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=7f1a9a7368d6f22c077f8bef8d7a5200
protocol HTTPClientProtocol {
    func fetch<T: Codable>(api: API) async throws -> T
    func testFetch<T: Codable>(api: API) async throws -> T
}

//TODO: 클래스 전면 리팩토링
//http메소드 주입처리
//repository 클래스와의 연관성 처리
class HTTPClient: HTTPClientProtocol {
    
    func fetch<T: Codable>(api: API) async throws -> T {
        
        guard let url = api.url else { throw HTTPError.badURL }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HTTPError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
            throw HTTPError.errorDecodingData
        }
        return object
    }
    
    //query추가 위한 테스트
    func testFetch<T: Codable>(api: API) async throws -> T {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=7f1a9a7368d6f22c077f8bef8d7a5200"
        
        let components = URLComponents(string: urlString)
        let items = components?.queryItems ?? []
        for item in items {
            print("-----")
            print("name : \(item.name)")
            print("value : \(item.value)")
            print("-----")
        }
        
        var baseComponent = (URLComponents(string: "https://api.openweathermap.org/data/2.5/weather"))
        let cityName = URLQueryItem(name: "q", value: "seoul")
        let appID = URLQueryItem(name: "appid", value: "7f1a9a7368d6f22c077f8bef8d7a5200")
        baseComponent?.queryItems = [cityName, appID]
        
        guard let url = baseComponent?.url else { throw HTTPError.badURL }
        var request = URLRequest(url: url)
        request.httpMethod = api.httpMethod.rawValue
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HTTPError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
            throw HTTPError.errorDecodingData
        }
        return object
    }
}
