//
//  BasicCollectionViewModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/06.
//

import Foundation

//FirstVC에서 날씨 보여줄때 사용할 뷰의 뷰모델
class BasicCellModel {
    
    //input
    var didReceiveViewModel: (BasicCellViewModel) -> () = { viewModel in }
    
    //output
    var cellViewModel: BasicCellViewModel {
        return privateCellViewModel
    }
    
    //properties
    private var privateCellViewModel: BasicCellViewModel

    init() {
        self.privateCellViewModel = BasicCellViewModel()
        bind()
    }
    
    private func bind() {
        didReceiveViewModel = { [weak self] viewModel in
            self?.privateCellViewModel = viewModel
        }
    }
}
