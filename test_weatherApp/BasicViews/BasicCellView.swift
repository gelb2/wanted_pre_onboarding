//
//  BasicCellView.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import UIKit
import SwiftUI

//TODO: ui개선
class BasicCellView: UIView {
    
    var cityNameLabel: UILabel = UILabel()
    var iconImageView: UIImageView = UIImageView()
    var temperatureLabel: UILabel = UILabel()
    var humidityLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewHierachy()
        configureView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BasicCellView: Presentable {
    func initViewHierachy() {
        self.addSubview(cityNameLabel)
        self.addSubview(iconImageView)
        self.addSubview(temperatureLabel)
        self.addSubview(humidityLabel)
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            cityNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cityNameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 4),
            cityNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            cityNameLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
        ]
        
        constraints += [
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 32)
        ]
        
        constraints += [
            temperatureLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            temperatureLabel.trailingAnchor.constraint(equalTo: humidityLabel.leadingAnchor, constant: -8),
            temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ]
        
        constraints += [
            humidityLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            humidityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            humidityLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ]
    }
    
    func configureView() {
        self.backgroundColor = .white
        cityNameLabel.text = "서울"
        cityNameLabel.textColor = .black
        iconImageView.image = UIImage(named: "10d")
        temperatureLabel.text = "32"
        temperatureLabel.textAlignment = .left
        humidityLabel.text = "77"
        humidityLabel.textAlignment = .right
    }
    
    func bind() {
        
    }
}


#if canImport(SwiftUI) && DEBUG
struct BasicCellViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    // MARK: UIViewRepresentable
    func makeUIView(context: Context) -> some UIView {
        view
    }
    // MARK: UIViewRepresentable
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#endif

#if canImport(SwiftUI) && DEBUG
struct BasicCellViewPreviewProvider: PreviewProvider {
    static var previews: some View {
        BasicCellViewPreview {
            let cell = BasicCellView(frame: .zero)
            
            return cell
        }.previewLayout(.fixed(width: 80, height: 80))
    }
}

#endif
