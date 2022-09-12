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
    var cellViewModel: BasicCellViewModel
    
    //output

    init() {
        self.cellViewModel = BasicCellViewModel()
    }
}
