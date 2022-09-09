//
//  DetailViewModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/09.
//

import Foundation

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
