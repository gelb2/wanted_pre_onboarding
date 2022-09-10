//
//  BasicCollectionViewModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/06.
//

import Foundation

//FirstVC에서 날씨 보여줄때 사용할 뷰의 뷰모델
class BasicCellViewModel {
    
    //input
    var cityName: String
    var icon: String
    var temp: Double
    var humid: Double
    
    //output
    var tempString: String {
        return String(describing: temp).addTempratureSign()
    }
    
    var humidString: String {
        return String(describing: humid).addHumiditySign()
    }
    
    init() {
        self.cityName = ""
        self.icon = ""
        self.temp = 0.0
        self.humid = 0.0
    }
}
