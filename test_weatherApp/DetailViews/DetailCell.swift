//
//  DetailCell.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewHierachy()
        configureView()
        bind()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailCell: Presentable {
    func initViewHierachy() {
        
    }
    
    func configureView() {
        
    }
    
    func bind() {
        
    }
    
    
}

