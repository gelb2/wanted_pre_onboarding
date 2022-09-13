//
//  BasicCollectionViewModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/08.
//

import Foundation

class BasicContentViewModel {
    
    //input
    var didReceiveUserInput: (String) -> () = { userInput in }
    var didSelectItemInCollectionView:(_ indexPath: IndexPath) -> () = { (IndexPath) in }
    var didReceiveEntity: ([BasicWeatherEntity]) -> () = { entity in }
    
    //output
    @MainThreadActor var didReceiveViewModel: ( ((Void)) -> () )?
    @MainThreadActor var scrollToProperIndex: ( (Int) -> () )?
    @MainThreadActor var userInputNotValid: ( (String) -> () )?
    var propergateDidSelectItem: (_ String: String) -> () = { (String) in }
    var dataSource: [BasicCellModel] { return privateDataSource }
    
    //properties
    var privateDataSource: [BasicCellModel] = []
    
    init() {
        bind()
        
    }

    private func bind() {
        
        didReceiveUserInput = { [weak self] userInput in
            guard let self = self else { return }
            guard let index = self.findAndReturnSearchedItem(userInput: userInput) else {
                self.userInputNotValid?(userInput)
                return }
            self.scrollToProperIndex?(index)
        }

        didReceiveEntity = { [weak self] entity in
            self?.populateEntity(result: entity)
            self?.didReceiveViewModel?(())
        }
        
        didSelectItemInCollectionView = { [weak self] indexPath in
            guard let cityName = self?.findAndReturnSelectedItem(indexPathItem: indexPath.item) else { return }
            self?.propergateDidSelectItem(cityName)
        }
    }
    
    private func populateEntity(result:[BasicWeatherEntity]) {
        privateDataSource = result.map { entity -> BasicCellModel in
            let cellModel = BasicCellModel()
            let cellViewModel = BasicCellViewModel()
            cellViewModel.cityName = entity.cityName
            cellViewModel.humid = entity.main.humidity
            cellViewModel.temp = entity.main.temp
            
            //TODO: 서버 api에서 weather는 배열이다...왜지...도큐먼트를 봐도 확실한 설명이 없어 보인다...
            cellViewModel.icon = entity.weather.first?.icon ?? ""
            
            cellModel.didReceiveViewModel(cellViewModel)
            
            
            return cellModel
        }
    }
    
    private func findAndReturnSearchedItem(userInput: String) -> Int? {
        let tempDataSource = privateDataSource.map { cellModel in
            return cellModel.cellViewModel.cityName
        }
        
        var index: Int?
        for i in 0..<tempDataSource.count {
            if tempDataSource[i].contains(userInput) {
                index = i
            }
        }
        
        return index
    }
    
    private func findAndReturnSelectedItem(indexPathItem: Int) -> String {
        privateDataSource[indexPathItem].cellViewModel.cityName
    }
}
