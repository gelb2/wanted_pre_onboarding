//
//  BasicCollectionViewModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/08.
//

import Foundation
//TODO: 어떻게 해야 basicModel -> basicCollectionViewModel 방향과 basicCollectionViewModel -> basicModel 의 통신, 데이터흐름을 깔끔하게 할 수 있지...
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
