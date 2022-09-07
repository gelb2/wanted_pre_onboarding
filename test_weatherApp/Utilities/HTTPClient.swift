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
}

//TODO: 클래스 전면 리팩토링
//http메소드 주입처리
//repository 클래스와의 연관성 처리
class HTTPClient: HTTPClientProtocol {
    
    func fetch<T: Codable>(api: API) async throws -> T {
        //TODO: 쿼리 넣는 방법 개선
        //TODO: get인지, post인지, patch인지 등 암튼 쿼리로 넣어야 할 지 파라미터로 넣어야 할 지에 대한 분기 및 로직 개선
        var baseComponent = api.baseURLSet
        let cityName = api.querySet
        let appID = api.appIDSet
        let langQuery = api.langSet
        baseComponent?.queryItems = [cityName, appID, langQuery]
        
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
