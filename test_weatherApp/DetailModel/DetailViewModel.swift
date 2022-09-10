//
//  DetailViewModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/09.
//

import Foundation
//TODO: 그냥 데이터소스 배열을 주입받게 하는 것이 아닌 얘가 어떤 밸류를 받으면 그 밸류로 데이터소스를 만드는 로직을 수행하게끔 연관된 로직을 수정...
class DetailViewModel {
    //input
    var didReceivedDataSource: (_: DetailDataSourceModel) -> () = { model in }
    
    //output
    var dataSource: DetailDataSourceModel { return privateDataSource }
    
    //properties
    var privateDataSource: DetailDataSourceModel = DetailDataSourceModel()
    
    init() {
        bind()
    }

    private func bind() {
        didReceivedDataSource = { [weak self] model in
            self?.privateDataSource = model
        }
    }
}
