//
//  Repository.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/06.
//

import Foundation

protocol RepositoryProtocol {
    var httpClient: HTTPClientProtocol { get set }
    func fetch<T: Codable>(api: API) async throws -> T
    func testHandleAPI(api: API) -> URL?
}

//네트워크 콜 관련, 캐쉬 관련 클래스들을 담고 있게끔
//TODO: httpClient, viewModel 클래스들과의 관계, 주입 관련 처리
class Repository: RepositoryProtocol {
    
    var httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    //TODO: repository가 httpClient의 메소드를 호출 및 콜백 처리 할 수 있게끔 추가
    func fetch<T: Codable>(api: API) async throws -> T {
        guard let url = testHandleAPI(api: api) else { throw HTTPError.iosDevloperIsStupid }
        let result: T = try await httpClient.fetch(url: url)
        return result
    }
    
    func testHandleAPI(api: API) -> URL? {
        //TODO: url 영문 아닌 한글도 되도록 allowQuery옵션 추가
        var url: URL?
        
        switch api {
        case .weatherData(.cityName(let name)):
            url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=7f1a9a7368d6f22c077f8bef8d7a5200")
        case .weatherData(.cityCoordination(lat: let lat, lon: let lon)):
            break
        }
        return url
    }
    
}
