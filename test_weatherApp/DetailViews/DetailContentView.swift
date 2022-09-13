//
//  DetailCellView.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import UIKit
import SwiftUI

//TODO: ui개선 : 좀 더 나은 방향으로 (ex. 그림자 추가 같은 더 예쁜거...)
class DetailContentView: UIView, DetailContentViewStyling, ActivityIndicatorViewStyling {
    
    //input
    var isPushedByNavi: (Bool) -> () = { bool in }
    
    //output
    
    //properties
    private var viewModel: DetailViewModel
    private var isSuperViewPushedByNavi: Bool = false {
        didSet {
            closeButton.isHidden = isSuperViewPushedByNavi
        }
    }
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var scrollView: UIScrollView = UIScrollView()
        
    var verticalStackView: UIStackView = UIStackView()
    var closeButton: UIButton = UIButton()
    var randomButton: UIButton = UIButton()
    var buttonStackView: UIStackView = UIStackView()
    var titleView: UIView = UIView()
    var firstStackView = UIStackView()
    var secondStackView = UIStackView()
    var thirdStackView = UIStackView()
    var fourthStackView = UIStackView()
    
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

    init(viewModel: DetailViewModel) {
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

extension DetailContentView: LoadingIndicatorPresentable { }

extension DetailContentView: Presentable {
    func initViewHierarchy() {
        
        self.addSubview(scrollView)
        scrollView.addSubview(verticalStackView)
        self.addSubview(activityIndicator)
        
        verticalStackView.addArrangedSubview(buttonStackView)
        verticalStackView.addArrangedSubview(titleView)
        verticalStackView.addArrangedSubview(firstStackView)
        verticalStackView.addArrangedSubview(secondStackView)
        verticalStackView.addArrangedSubview(thirdStackView)
        verticalStackView.addArrangedSubview(fourthStackView)
        
        titleView.addSubview(iconImageView)
        titleView.addSubview(cityNameLabel)

        buttonStackView.addArrangedSubview(closeButton)
        buttonStackView.addArrangedSubview(randomButton)
        
        firstStackView.addArrangedSubview(presentHumidityLabel)
        firstStackView.addArrangedSubview(weatherDescriptionLabel)

        secondStackView.addArrangedSubview(presentTemperatureLabel)
        secondStackView.addArrangedSubview(feeledTemperatureLabel)

        thirdStackView.addArrangedSubview(minimumTemperatureLabel)
        thirdStackView.addArrangedSubview(maximumTemperatureLabel)

        fourthStackView.addArrangedSubview(pressureLabel)
        fourthStackView.addArrangedSubview(windSpeedLabel)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        thirdStackView.translatesAutoresizingMaskIntoConstraints = false
        fourthStackView.translatesAutoresizingMaskIntoConstraints = false

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
            iconImageView.trailingAnchor.constraint(equalTo: cityNameLabel.leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalTo: cityNameLabel.heightAnchor),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            iconImageView.leadingAnchor.constraint(greaterThanOrEqualTo: titleView.leadingAnchor)
        ]

        constraints += [
            cityNameLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            cityNameLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            cityNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: titleView.trailingAnchor)
        ]
        
        constraints += [
            buttonStackView.heightAnchor.constraint(equalToConstant: 100),
            buttonStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 200),
            titleView.widthAnchor.constraint(equalTo: self.widthAnchor),
            firstStackView.heightAnchor.constraint(equalToConstant: 200),
            firstStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            secondStackView.heightAnchor.constraint(equalToConstant: 200),
            secondStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            thirdStackView.heightAnchor.constraint(equalToConstant: 200),
            thirdStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            fourthStackView.heightAnchor.constraint(equalToConstant: 200),
            fourthStackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ]
        
        constraints += [
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
    }
    
    func configureView() {
        self.backgroundColor = .white
        
        scrollView.showsHorizontalScrollIndicator = true
        
        closeButton.addStyles(style: closeButtonStyle)
        
        randomButton.addStyles(style: randomButtonStyle)
        
        activityIndicator.addStyles(style: indicatorStyle)
        
        verticalStackView.addStyles(style: verticalStackViewStyle)
        
        buttonStackView.addStyles(style: horizontalStackViewStyle)
        firstStackView.addStyles(style: horizontalStackViewStyle)
        secondStackView.addStyles(style: horizontalStackViewStyle)
        thirdStackView.addStyles(style: horizontalStackViewStyle)
        fourthStackView.addStyles(style: horizontalStackViewStyle)
        
        cityNameLabel.addStyles(style: cityNameLabelStyle)
        
        iconImageView.addStyles(style: iconImageViewStyle)
        
        presentTemperatureLabel.addStyles(style: detailContentViewLabelStyle)
        
        feeledTemperatureLabel.addStyles(style: detailContentViewLabelStyle)
        
        presentHumidityLabel.addStyles(style: detailContentViewLabelStyle)
        
        minimumTemperatureLabel.addStyles(style: detailContentViewLabelStyle)
        
        maximumTemperatureLabel.addStyles(style: detailContentViewLabelStyle)
        
        pressureLabel.addStyles(style: detailContentViewLabelStyle)
        
        windSpeedLabel.addStyles(style: detailContentViewLabelStyle)
        
        weatherDescriptionLabel.addStyles(style: detailContentViewLabelStyle)
    }
    
    func bind() {
        
        isPushedByNavi = { [weak self] bool in
            self?.isSuperViewPushedByNavi = bool
        }
        
        scrollView.isHidden = true
        activityIndicator.startAnimating()
        
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        randomButton.addTarget(self, action: #selector(random), for: .touchUpInside)
        
        viewModel.didReceiveViewModel = { [weak self] _ in
            self?.scrollView.isHidden = false
            self?.setData()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    //TODO: dataSet 해주는 과정 자체가 MVVM 스럽지 못하다. 더 MVVM 스럽게 수정필요
    func setData() {
        cityNameLabel.text = viewModel.dataSource.cityName
        
        iconImageView.loadImage(urlString: viewModel.dataSource.icon)
        
        presentTemperatureLabel.text = viewModel.dataSource.presentTempString
        
        feeledTemperatureLabel.text = viewModel.dataSource.feelsLikeTempString
        
        presentHumidityLabel.text = viewModel.dataSource.presentHumidString
        
        minimumTemperatureLabel.text = viewModel.dataSource.min_TempString
        
        maximumTemperatureLabel.text = viewModel.dataSource.max_TempString
        
        pressureLabel.text = viewModel.dataSource.pressureString
        
        windSpeedLabel.text = viewModel.dataSource.windSpeedString
        
        weatherDescriptionLabel.text = viewModel.dataSource.weatherDesc
    }
    
    @objc func dismiss() {
        viewModel.dismissButtonPressed()
    }
    
    @objc func random() {
        viewModel.randomButtonPressed()
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
            let cell = DetailContentView(viewModel: DetailViewModel())
            
            return cell
        }.previewLayout(.fixed(width: 180, height:300))
    }
}

#endif

