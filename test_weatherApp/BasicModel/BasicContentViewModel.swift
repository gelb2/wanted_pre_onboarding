//
//  BasicCollectionViewModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/08.
//

import Foundation

class BasicContentViewModel {
    
    //input
    var didSelectItemInCollectionView:(_ indexPath: IndexPath) -> () = { (IndexPath) in }
    var didReceiveEntity: ([BasicWeatherEntity]) -> () = { entity in }
    
    //output
    var didReceiveViewModel = { }
    var propergateDidSelectItem: (_ String: String) -> () = { (String) in }
    var dataSource: [BasicCellModel] { return privateDataSource }
    
    //properties
    var privateDataSource: [BasicCellModel] = []
    
    init() {
        bind()
        
    }

    private func bind() {

        didReceiveEntity = { [weak self] entity in
            self?.populateEntity(result: entity)
            self?.didReceiveViewModel()
        }
        
        didSelectItemInCollectionView = { [weak self] indexPath in
            print("BasicContentView item didSelected indexPath : \(indexPath.item)")
            guard let cityName = self?.findAndReturnSelectedItem(indexPathItem: indexPath.item) else { return }
            self?.propergateDidSelectItem(cityName)
        }
    }
    
    private func populateEntity(result:[BasicWeatherEntity]) {
        privateDataSource = result.map { entity -> BasicCellModel in
            let cellModel = BasicCellModel()

            cellModel.cellViewModel.cityName = entity.cityName
            cellModel.cellViewModel.humid = entity.main.humidity
            cellModel.cellViewModel.temp = entity.main.temp
            
            //TODO: 서버 api에서 weather는 배열이다...왜지...도큐먼트를 봐도 확실한 설명이 없어 보인다...
            cellModel.cellViewModel.icon = entity.weather.first?.icon ?? ""
            return cellModel
        }
    }
    
    private func findAndReturnSelectedItem(indexPathItem: Int) -> String {
        privateDataSource[indexPathItem].cellViewModel.cityName
    }
}
