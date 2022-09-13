//
//  BasicCellView.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import UIKit
import SwiftUI

//TODO: ui개선 : 좀 더 나은 방향으로 (ex. 그림자 추가 같은 더 예쁜거...)
class BasicCellView: UIView, BasicCellStyling {
    
    //input
    var didReceivedViewModel: (BasicCellViewModel) -> () = { viewModel in }
    
    //output
    
    //properties
    private var viewModel: BasicCellViewModel
    
    var cityNameLabel: UILabel = UILabel()
    var iconImageView: CacheImageView = CacheImageView()
    var temperatureLabel: UILabel = UILabel()
    var humidityLabel: UILabel = UILabel()
    var bottomStackView: UIStackView = UIStackView()
    
    init(viewModel: BasicCellViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
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
            bottomStackView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4),
            bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
    }
    
    func configureView() {
        self.backgroundColor = .white
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 10.0, height: -3.0)
        self.layer.shadowRadius = 10
        
        cityNameLabel.addStyles(style: cityNameLabelStyle)
        
        iconImageView.image = UIImage(systemName: "exclamationmark.circle.fill")
        
        temperatureLabel.addStyles(style: tempratureLabelStyle)
        
        humidityLabel.addStyles(style: humidityLabelStyle)
        
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fillEqually
    }
    
    func bind() {
        didReceivedViewModel = { [weak self] viewModel in
            self?.viewModel = viewModel
            DispatchQueue.main.async {
                self?.setData()
            }
        }
    }
    
    //TODO: dataSet 해주는 과정 자체가 MVVM 스럽지 못하다. 더 MVVM 스럽게 수정필요
    func setData() {
        cityNameLabel.text = viewModel.cityName
        iconImageView.loadImage(urlString: viewModel.icon)
        temperatureLabel.text = viewModel.tempString
        humidityLabel.text = viewModel.humidString
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
            let cell = BasicCellView(viewModel: BasicCellViewModel())
            
            return cell
        }.previewLayout(.fixed(width: 100, height: 100))
    }
}

#endif
