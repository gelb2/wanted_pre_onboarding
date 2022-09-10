//
//  DetailCellView.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import UIKit
import SwiftUI

//TODO: ui개선 : 좀 더 나은 방향으로 (ex. 그림자 추가 같은 더 예쁜거...)
class DetailContentView: UIView {
    
    //input
    var didReceivedViewModel: (_: DetailViewModel) -> () = { viewModel in }
    
    //output
    
    
    //properties
    private var viewModel: DetailViewModel = DetailViewModel()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var scrollView: UIScrollView = UIScrollView()
        
    var verticalStackView: UIStackView = UIStackView()
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

extension DetailContentView: LoadingIndicatorPresentable { }

extension DetailContentView: Presentable {
    func initViewHierachy() {
        
        self.addSubview(scrollView)
        scrollView.addSubview(verticalStackView)
        self.addSubview(activityIndicator)

        verticalStackView.addArrangedSubview(titleView)
        verticalStackView.addArrangedSubview(firstStackView)
        verticalStackView.addArrangedSubview(secondStackView)
        verticalStackView.addArrangedSubview(thirdStackView)
        verticalStackView.addArrangedSubview(fourthStackView)
        
        titleView.addSubview(iconImageView)
        titleView.addSubview(cityNameLabel)

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
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
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
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
        ]

        constraints += [
            cityNameLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            cityNameLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor)
        ]
        
        constraints += [
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
        
        activityIndicator.tintColor = .red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .red
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        
        firstStackView.distribution = .fillEqually
        secondStackView.distribution = .fillEqually
        thirdStackView.distribution = .fillEqually
        fourthStackView.distribution = .fillEqually
        
        cityNameLabel.text = "서울"
        cityNameLabel.textColor = .black
        cityNameLabel.textAlignment = .center
        cityNameLabel.font = UIFont.systemFont(ofSize: 48)
        
        iconImageView.image = UIImage(named: "10d")
        
        presentTemperatureLabel.text = "32"
        presentTemperatureLabel.textAlignment = .center
        presentTemperatureLabel.numberOfLines = 2
        
        feeledTemperatureLabel.text = "35"
        feeledTemperatureLabel.textAlignment = .center
        feeledTemperatureLabel.numberOfLines = 2
        
        presentHumidityLabel.text = "77%"
        presentHumidityLabel.textAlignment = .center
        presentHumidityLabel.numberOfLines = 2
        
        minimumTemperatureLabel.text = "15%"
        minimumTemperatureLabel.textAlignment = .center
        minimumTemperatureLabel.numberOfLines = 2
        
        maximumTemperatureLabel.text = "54%"
        maximumTemperatureLabel.textAlignment = .center
        maximumTemperatureLabel.numberOfLines = 2
        
        pressureLabel.text = "0.25"
        pressureLabel.textAlignment = .center
        pressureLabel.numberOfLines = 2
        
        windSpeedLabel.text = "876"
        windSpeedLabel.textAlignment = .center
        windSpeedLabel.numberOfLines = 2
        
        weatherDescriptionLabel.text = "청명함"
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.numberOfLines = 2
    }
    
    func bind() {
        scrollView.isHidden = true
        activityIndicator.startAnimating()
        didReceivedViewModel = { [weak self] viewModel in
            self?.viewModel = viewModel
            DispatchQueue.main.async {
                self?.scrollView.isHidden = false
                self?.setData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
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

