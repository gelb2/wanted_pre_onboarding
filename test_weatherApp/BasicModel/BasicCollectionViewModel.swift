//
//  BasicCollectionViewModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/08.
//

import Foundation

class BasicCollectionViewModel {
    
    //input
    var didSelectItemInCollectionView:(_ indexPath: IndexPath) -> () = { (IndexPath) in }
    var didReceivedDataSource: (_: [BasicCellViewModel]) -> () = { model in }
    
    //output
    var propergateDidSelectItem: (_ String: String) -> () = { (String) in }
    var dataSource: [BasicCellViewModel] { return privateDataSource }
    
    //properties
    var privateDataSource: [BasicCellViewModel] = []
    
    init() {
        bind()
    }

    private func bind() {

        didReceivedDataSource = { [weak self] model in
            self?.privateDataSource = model
        }
        
        didSelectItemInCollectionView = { [weak self] indexPath in
            print("BasicContentView item didSelected indexPath : \(indexPath.item)")
            guard let cityName = self?.findAndReturnSelectedItem(indexPathItem: indexPath.item) else { return }
            self?.propergateDidSelectItem(cityName)
        }
    }
    
    private func findAndReturnSelectedItem(indexPathItem: Int) -> String {
        privateDataSource[indexPathItem].cityName
    }
}
