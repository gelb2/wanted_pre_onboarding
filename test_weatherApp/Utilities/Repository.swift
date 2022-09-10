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
}

//네트워크 콜 관련, 캐쉬 관련 클래스들을 담고 있게끔
//TODO: httpClient, viewModel 클래스들과의 관계, 주입 관련 처리
class Repository: RepositoryProtocol {
    
    var httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func fetch<T: Codable>(api: API) async throws -> T {
        let result: T = try await httpClient.fetch(api: api)
        return result
    }
}
