//
//  BasicCollectionViewModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/08.
//

import Foundation

class BasicCollectionViewModel {
    
    //input
    var inputCallBack = { }
    var didSelectItemCallBack:(_ indexPath: IndexPath) -> () = { (IndexPath) in }
    
    //output
    var outputCallBack = { }
    
    var dataSource: [BasicCellViewModel]
    
    init(dataSource: [BasicCellViewModel]) {
        self.dataSource = dataSource
        bind()
    }
    
    //TODO: 얘는 필요 없을 듯 한데 지우자
    //어떻게 해야 basicModel -> basicCollectionViewModel 방향과 basicCollectionViewModel -> basicModel 의 통신, 데이터흐름을 깔끔하게 할 수 있지...
    func populateData() {

    }
    
    private func dataIsReadyToPresent() {
        print("BasicCollectionViewModel dataIsReady")
        outputCallBack()
    }
    
    private func bind() {
        inputCallBack = { [weak self] in
            print("BasicCollectionViewModel inputCallBack")
            self?.dataIsReadyToPresent()
        }
        
        didSelectItemCallBack = { indexPath in
            print("BasicContentView item didSelected indexPath : \(indexPath.item)")
        }
    }
}
