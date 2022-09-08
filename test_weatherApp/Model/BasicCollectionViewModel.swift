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
    var propergateDidSelectItem: (_ indexPathRow: Int) -> () = { (Int) in }
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
            self?.propergateDidSelectItem(indexPath.item)
        }
    }
}
