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
    case badURL, badResponse, errorDecodingData, invalidURL
}

//https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=7f1a9a7368d6f22c077f8bef8d7a5200
protocol HTTPClientProtocol {
    func fetch<T: Codable>(url: URL) async throws -> T
}

class HTTPClient: HTTPClientProtocol {
    
    func fetch<T: Codable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HTTPError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
            throw HTTPError.errorDecodingData
        }
        return object
    }
    
}
