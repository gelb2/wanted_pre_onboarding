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
    func test<T: Codable>(api: API, completion: @escaping (T) -> ()) throws
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
        let result: T = try await httpClient.fetch(api: api)
        return result
    }
    
    func test<T: Codable>(api: API, completion: @escaping (T) -> ()) throws {
        Task {
            let result: T = try await httpClient.fetch(api: api)
            completion(result)
        }
    }
}
