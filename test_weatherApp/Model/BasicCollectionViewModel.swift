//
//  BasicCollectionViewModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/06.
//

import Foundation

//FirstVC에서 날씨 보여줄때 사용할 뷰의 뷰모델
class BasicCollectionViewModel {
    var cityName: String
    var icon: String
    var temp: Double
    var humid: Double
    
    init() {
        self.cityName = ""
        self.icon = ""
        self.temp = 0.0
        self.humid = 0.0
    }
}
