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
    var dataSource: [BasicCellViewModel] { return privateDataSource }
    
    //properties
    var privateDataSource: [BasicCellViewModel] = []
    
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
        privateDataSource = result.map { entity -> BasicCellViewModel in
            let weather = BasicCellViewModel()
            weather.cityName = entity.cityName
            weather.humid = entity.main.humidity
            weather.temp = entity.main.temp
            
            //TODO: 서버 api에서 weather는 배열이다...왜지...도큐먼트를 봐도 확실한 설명이 없어 보인다...
            weather.icon = entity.weather.first?.icon ?? ""
            return weather
        }
    }
    
    private func findAndReturnSelectedItem(indexPathItem: Int) -> String {
        privateDataSource[indexPathItem].cityName
    }
}
