//
//  WeatherCell.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import UIKit

class BasicCell: UICollectionViewCell {
    
    var cellView: BasicCellView = BasicCellView()
    
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

extension BasicCell: Presentable {
    func initViewHierachy() {
        self.contentView.addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        var constarints:[NSLayoutConstraint] = []
        
        defer { NSLayoutConstraint.activate(constarints) }
        
        constarints += [
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
    }
    
    func configureView() {
        
    }
    
    func bind() {
        
    }
    
    
}
