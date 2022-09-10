//
//  BasicCellView.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import UIKit
import SwiftUI

//TODO: ui개선 : 좀 더 나은 방향으로 (ex. 그림자 추가 같은 더 예쁜거...)
class BasicCellView: UIView {
    
    var cityNameLabel: UILabel = UILabel()
    var iconImageView: CacheImageView = CacheImageView()
    var temperatureLabel: UILabel = UILabel()
    var humidityLabel: UILabel = UILabel()
    var bottomStackView: UIStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewHierarchy()
        configureView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BasicCellView: Presentable {
    func initViewHierarchy() {
        self.addSubview(cityNameLabel)
        self.addSubview(iconImageView)
        self.addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(temperatureLabel)
        bottomStackView.addArrangedSubview(humidityLabel)
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            cityNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cityNameLabel.bottomAnchor.constraint(equalTo: iconImageView.topAnchor)
        ]
        
        constraints += [
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            iconImageView.heightAnchor.constraint(equalTo: self.iconImageView.widthAnchor)
        ]
        
        constraints += [
            bottomStackView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 16),
            bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
    }
    
    func configureView() {
        self.backgroundColor = .white
        cityNameLabel.text = "seoul"
        cityNameLabel.textColor = .black
        cityNameLabel.textAlignment = .center
        cityNameLabel.font = UIFont.systemFont(ofSize: 24)
        
        iconImageView.image = UIImage(named: "10d")
        
        temperatureLabel.text = "32.14".addTempratureSign()
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = UIFont.systemFont(ofSize: 16)
        
        humidityLabel.text = "77".addHumiditySign()
        humidityLabel.textAlignment = .center
        humidityLabel.font = UIFont.systemFont(ofSize: 16)
        
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fill
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
        }.previewLayout(.fixed(width: 100, height: 100))
    }
}

#endif
