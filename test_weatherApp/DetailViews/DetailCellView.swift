//
//  DetailCellView.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import UIKit
import SwiftUI

//TODO: ui개선
class DetailCellView: UIView {
    
    var cityNameLabel: UILabel = UILabel()
    var iconImageView: UIImageView = UIImageView()
    var presentTemperatureLabel: UILabel = UILabel()
    var feeledTemperatureLabel: UILabel = UILabel()
    var presentHumidityLabel: UILabel = UILabel()
    var minimumTemperatureLabel: UILabel = UILabel()
    var maximumTemperatureLabel: UILabel = UILabel()
    var pressureLabel: UILabel = UILabel()
    var weatherDescriptionLabel: UILabel = UILabel()
    var divider: UIView = UIView()
    
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

extension DetailCellView: Presentable {
    func initViewHierachy() {
        self.addSubview(cityNameLabel)
        self.addSubview(iconImageView)
        self.addSubview(presentTemperatureLabel)
        self.addSubview(presentHumidityLabel)
        self.addSubview(divider)
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        presentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        presentHumidityLabel.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        
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
            presentTemperatureLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            presentTemperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            presentTemperatureLabel.trailingAnchor.constraint(equalTo: presentHumidityLabel.leadingAnchor, constant: -8),
            presentTemperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ]
        
        constraints += [
            presentHumidityLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            presentHumidityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            presentHumidityLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ]
    }
    
    func configureView() {
        self.backgroundColor = .white
        cityNameLabel.text = "서울"
        cityNameLabel.textColor = .black
        iconImageView.image = UIImage(named: "10d")
        presentTemperatureLabel.text = "32"
        presentTemperatureLabel.textAlignment = .left
        presentHumidityLabel.text = "77"
        presentHumidityLabel.textAlignment = .right
    }
    
    func bind() {
        
    }
}


#if canImport(SwiftUI) && DEBUG
struct DetailCellViewPreview<View: UIView>: UIViewRepresentable {
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
struct DetailCellViewPreviewProvider: PreviewProvider {
    static var previews: some View {
        BasicCellViewPreview {
            let cell = DetailCellView(frame: .zero)
            
            return cell
        }.previewLayout(.fixed(width: 80, height: 80))
    }
}

#endif

