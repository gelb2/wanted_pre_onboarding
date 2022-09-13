//
//  UIViewStyle.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/13.
//

import Foundation
import UIKit

protocol Styling {}

protocol BasicCellStyling: Styling { }

extension BasicCellStyling {
    var cityNameLabelStyle: (UILabel) -> () {
        return {
            $0.text = "seoul"
            $0.textColor = .yellow
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 24)
        }
    }
    
    var tempratureLabelStyle: (UILabel) -> () {
        return {
            $0.text = "32.14".addTempratureSign()
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    var humidityLabelStyle: (UILabel) -> () {
        return {
            $0.text = "77".addHumiditySign()
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    var bottomStackViewStyle: (UIStackView) -> () {
        return {
            $0.axis = .vertical
            $0.distribution = .fillEqually
        }
    }
}

//TODO: uilabel의 익스텐션을 파는 것은 너무 협소해 보인다...다른 uiview 서브클래스들에 대한 대응은 어떻게 하지...
extension UILabel {
    
    @discardableResult
    func addStyles(style: (Self) ->()) -> Self {
        style(self)
        return self
    }
}

