//
//  UIViewStyle.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/13.
//

import Foundation
import UIKit

protocol Styling {}

protocol BasicNavigationControllerStyling: Styling { }

extension BasicNavigationControllerStyling {
    var navigationBarStyle: (UINavigationBar) -> () {
        {
            $0.barTintColor = .blue
            $0.shadowImage = UIImage()
        }
    }
}

protocol ActivityIndicatorViewStyling: Styling { }

extension ActivityIndicatorViewStyling {
    var indicatorStyle: (UIActivityIndicatorView) -> () {
        {
            $0.tintColor = .red
            $0.hidesWhenStopped = true
            $0.style = .large
            $0.color = .red
        }
    }
}

protocol BasicContentViewStyling: Styling { }

extension BasicContentViewStyling {
    
    var collectionViewStyle: (UICollectionView) -> () {
        {
            $0.backgroundColor = .white
        }
    }
    
    var collectionViewFlowLayoutStyle: (UICollectionViewFlowLayout) -> () {
        {
            // TODO: 지역변수들 다른 방법으로 만들고 할당해주기...
            let cellSpacing: CGFloat = cellSpacing
            let columns: CGFloat = columns
            $0.scrollDirection = .vertical
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.minimumLineSpacing = cellSpacing
            $0.minimumInteritemSpacing = cellSpacing
            let width = (UIScreen.main.bounds.width - cellSpacing * 2) / columns
            $0.itemSize = CGSize(width: width , height: width)
        }
    }
    
    private var cellSpacing: CGFloat {
        return 10.0
    }
    
    private var columns: CGFloat {
        return 3.0
    }
}

protocol BasicCellStyling: Styling { }

extension BasicCellStyling {
    
    var basicCellViewStyle: (UIView) -> () {
        return {
            $0.backgroundColor = .white
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowOffset = CGSize(width: 10.0, height: -3.0)
            $0.layer.shadowRadius = 10
        }
    }
    
    var cityNameLabelStyle: (UILabel) -> () {
        return {
            $0.text = "seoul"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 24)
        }
    }
    
    var iconImageViewStyle: (UIImageView) -> () {
        {
            $0.image = UIImage(systemName: "exclamationmark.circle.fill")
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

protocol DetailContentViewStyling: Styling {
    
}

extension DetailContentViewStyling {
    var closeButtonStyle: (UIButton) -> () {
        {
            $0.setTitle("닫기", for: .normal)
            $0.setTitleColor(.red, for: .normal)
        }
    }
    
    var randomButtonStyle: (UIButton) -> () {
        {
            $0.setTitle("랜덤", for: .normal)
            $0.setTitleColor(.blue, for: .normal)
        }
    }
    
    var verticalStackViewStyle: (UIStackView) -> () {
        {
            $0.axis = .vertical
            $0.spacing = 8
        }
    }
    
    var horizontalStackViewStyle: (UIStackView) -> () {
        {
            $0.distribution = .fillEqually
        }
    }
    
    var cityNameLabelStyle: (UILabel) -> () {
        {
            $0.text = "서울"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 48)
        }
    }
    
    var iconImageViewStyle: (UIImageView) -> () {
        {
            $0.image = UIImage(named: "10d")
        }
    }
    
    var detailContentViewLabelStyle: (UILabel) -> () {
        {
            $0.text = "35"
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
    }
}


//uiview나 uiviewcontroller나 init할때 init(coder: nscoder) 를 쓰는 경우가 있다...(ex.storyboard, xib init)
//그럼 nscoder 클래스를 활용해 uiview인스턴스가 메소드를 호출하게끔 트릭을 구현할 수 있지 않을까 하는 발상에서 출발함...
//그래서 나온 결과
//1. 공식 도큐먼트를 찾아보니 uiview, nsview같은 것들은 nscoding을 따른다고 함
//2. nscoder는 nsobject를 상속받는다고 함
//3. 근데 nscoder를 활용해서 해보려니 잘 안됨...
//4. 혹시나 해서 nscoding으로 뭔가가 되지 않을까 해서 해보니 됨...
//5. nscoder와 nscoding의 관계는 찾아도 잘 나오지 않음...둘이 분명히 어떤 관계가 있어서 이 로직이 작동하는게 맞는데...
extension NSCoding where Self: UIView {
    @discardableResult
    func addStyles(style: (Self) ->()) -> Self {
        style(self)
        return self
    }
}

extension NSCoding where Self: UICollectionViewLayout {
    @discardableResult
    func addStyles(style: (Self) ->()) -> Self {
        style(self)
        return self
    }
}
