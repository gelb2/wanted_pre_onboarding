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
//TODO: httpClient, viewModel 클래스들과의 관계, 주입 관련 처리
class Repository: RepositoryProtocol {
    
    var httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    //TODO: repository가 httpClient의 메소드를 호출 및 콜백 처리 할 수 있게끔 추가
    func request(url: URL) {
        
    }
    
}
