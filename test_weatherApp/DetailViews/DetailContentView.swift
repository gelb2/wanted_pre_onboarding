//
//  DetailCellView.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import UIKit
import SwiftUI

//TODO: ui개선
//필수로 표시해야 하는 정보
//도시이름, 날씨아이콘, 현재기온, 체감기온, 현재습도, 최저기온, 최고기온, 기압, 풍속, 날씨설명
class DetailContentView: UIView {
    
    var scrollView: UIScrollView = UIScrollView()
        
    var verticalStackView: UIStackView = UIStackView()
    
    var titleStackView = UIStackView()
    var icon_humidStackView = UIStackView()
    var present_feelTempStackView = UIStackView()
    var min_maxTempStackView = UIStackView()
    var pressure_windStackView = UIStackView()
    var weatherDescStackView = UIStackView()
    
    var cityNameLabel: UILabel = UILabel()
    var iconImageView: CacheImageView = CacheImageView()
    var presentTemperatureLabel: UILabel = UILabel()
    var feeledTemperatureLabel: UILabel = UILabel()
    var presentHumidityLabel: UILabel = UILabel()
    var minimumTemperatureLabel: UILabel = UILabel()
    var maximumTemperatureLabel: UILabel = UILabel()
    var pressureLabel: UILabel = UILabel()
    var windSpeedLabel: UILabel = UILabel()
    var weatherDescriptionLabel: UILabel = UILabel()

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

extension DetailContentView: Presentable {
    func initViewHierachy() {

        self.addSubview(scrollView)
        scrollView.addSubview(verticalStackView)

        verticalStackView.addArrangedSubview(titleStackView)
        verticalStackView.addArrangedSubview(icon_humidStackView)
        verticalStackView.addArrangedSubview(present_feelTempStackView)
        verticalStackView.addArrangedSubview(min_maxTempStackView)
        verticalStackView.addArrangedSubview(pressure_windStackView)
        verticalStackView.addArrangedSubview(weatherDescStackView)
        
        titleStackView.addArrangedSubview(cityNameLabel)

        icon_humidStackView.addArrangedSubview(iconImageView)
        icon_humidStackView.addArrangedSubview(presentHumidityLabel)

        present_feelTempStackView.addArrangedSubview(presentTemperatureLabel)
        present_feelTempStackView.addArrangedSubview(feeledTemperatureLabel)

        min_maxTempStackView.addArrangedSubview(minimumTemperatureLabel)
        min_maxTempStackView.addArrangedSubview(maximumTemperatureLabel)

        pressure_windStackView.addArrangedSubview(pressureLabel)
        pressure_windStackView.addArrangedSubview(windSpeedLabel)

        weatherDescStackView.addArrangedSubview(weatherDescriptionLabel)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        icon_humidStackView.translatesAutoresizingMaskIntoConstraints = false
        present_feelTempStackView.translatesAutoresizingMaskIntoConstraints = false
        min_maxTempStackView.translatesAutoresizingMaskIntoConstraints = false
        pressure_windStackView.translatesAutoresizingMaskIntoConstraints = false

        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        presentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        feeledTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        presentHumidityLabel.translatesAutoresizingMaskIntoConstraints = false
        minimumTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        maximumTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        var constraints: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            verticalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        
        constraints += [
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        constraints += [
            titleStackView.heightAnchor.constraint(equalToConstant: 200),
            titleStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            icon_humidStackView.heightAnchor.constraint(equalToConstant: 240),
            icon_humidStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            present_feelTempStackView.heightAnchor.constraint(equalToConstant: 350),
            present_feelTempStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            min_maxTempStackView.heightAnchor.constraint(equalToConstant: 270),
            min_maxTempStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            pressure_windStackView.heightAnchor.constraint(equalToConstant: 170),
            pressure_windStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            weatherDescStackView.heightAnchor.constraint(equalToConstant: 120),
            weatherDescStackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ]
    }
    
    func configureView() {
        self.backgroundColor = .white
        
        scrollView.showsHorizontalScrollIndicator = true
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        
        titleStackView.distribution = .fill
        icon_humidStackView.distribution = .fillEqually
        present_feelTempStackView.distribution = .fillEqually
        min_maxTempStackView.distribution = .fillEqually
        pressure_windStackView.distribution = .fillEqually
        weatherDescStackView.distribution = .fill
        
        cityNameLabel.text = "서울"
        cityNameLabel.textColor = .black
        cityNameLabel.textAlignment = .center
        
        iconImageView.image = UIImage(named: "10d")
        
        presentTemperatureLabel.text = "32"
        presentTemperatureLabel.textAlignment = .center
        
        feeledTemperatureLabel.text = "35"
        feeledTemperatureLabel.textAlignment = .center
        
        presentHumidityLabel.text = "77%"
        presentHumidityLabel.textAlignment = .center
        
        minimumTemperatureLabel.text = "15%"
        minimumTemperatureLabel.textAlignment = .center
        
        maximumTemperatureLabel.text = "54%"
        maximumTemperatureLabel.textAlignment = .center
        
        pressureLabel.text = "0.25"
        pressureLabel.textAlignment = .center
        
        windSpeedLabel.text = "876"
        windSpeedLabel.textAlignment = .center
        
        weatherDescriptionLabel.text = "청명함"
        weatherDescriptionLabel.textAlignment = .center
    }
    
    func bind() {
        
    }
}


#if canImport(SwiftUI) && DEBUG
struct DetailContentViewPreview<View: UIView>: UIViewRepresentable {
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
struct DetailContentViewPreviewProvider: PreviewProvider {
    static var previews: some View {
        DetailContentViewPreview {
            let cell = DetailContentView(frame: .zero)
            
            return cell
        }.previewLayout(.fixed(width: 180, height:300))
    }
}

#endif

