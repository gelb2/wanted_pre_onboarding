//
//  Repository.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/06.
//

import Foundation

protocol RepositoryProtocol {
    var httpClient: HTTPClientProtocol { get set }
}

//네트워크 콜 관련, 캐쉬 관련 클래스들을 담고 있게끔
class Repository: RepositoryProtocol {
    
    var httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func request(url: URL) {
        
    }
    
}
