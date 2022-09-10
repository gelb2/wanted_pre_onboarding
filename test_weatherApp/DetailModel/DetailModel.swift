//
//  DetailModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/08.
//

import Foundation

class DetailModel: AdditionalContextAddable {
    //input
    var addMoreContext: (String) -> () = { String in }
    
    //output
    var didReceivedViewModel: (_ viewModel: DetailViewModel) -> () = { viewModel in }
    var routeSubject = { } 
    
    //properties
    private var detailViewModel: DetailViewModel
    private var repository: RepositoryProtocol
    
    //일단 두번째 뷰가 전달받은 도시명 대로 api를 호출하는지 확인하는지 확인하고자 임의로 추가
    private var cityNameParam: String = ""

    //TODO: 뷰모델에 주입할 제네릭한 클래스(레포지토리, 캐쉬, 스트링, 불 값 등 뷰모델에 필요한 것들 다 넣어줄 수 있는) 만들고 그 클래스를 주입받게끔 하기
    init(repository: RepositoryProtocol) {
        self.repository = repository
        self.detailViewModel = DetailViewModel()
        self.bind()
    }
    
    func bind() {
        addMoreContext = { [weak self] string in
            self?.cityNameParam = string
        }
    }

    func populateData() {
        Task {
            let dataSource = await requestAPI()
            detailViewModel.didReceivedDataSource(dataSource)
            didReceivedViewModel(detailViewModel)
        }
    }

    private func requestAPI() async -> DetailDataSourceModel {
        let detailDataSourceModel: DetailDataSourceModel = DetailDataSourceModel()
        //도시이름, 날씨아이콘, 현재기온, 체감기온, 현재습도, 최저기온, 최고기온, 기압, 풍속, 날씨설명
        do {
            let result: BasicWeatherEntity = try await repository.fetch(api: .weatherData(.cityName(name: cityNameParam)))
            detailDataSourceModel.cityName = result.cityName
            detailDataSourceModel.icon = result.weather.first?.icon ?? ""
            detailDataSourceModel.presentTemp = result.main.temp
            detailDataSourceModel.feelsLikeTemp = result.main.feelsLikeTemp
            detailDataSourceModel.presentHumid = result.main.humidity
            detailDataSourceModel.min_Temp = result.main.tempMin
            detailDataSourceModel.max_Temp = result.main.tempMax
            detailDataSourceModel.pressure = result.main.pressure
            detailDataSourceModel.windSpeed = result.wind.speed
            detailDataSourceModel.weatherDesc = result.weather.first?.description ?? ""
        } catch {
            //TODO: 뷰모델이 에러 핸들링 하게 하기
            let error = error as? HTTPError
            switch error {
            case .invalidURL:
                print("❌ Error: \(String(describing: error))")
            case .errorDecodingData:
                print("❌ Error: \(String(describing: error))")
            case .badResponse:
                print("❌ Error: \(String(describing: error))")
            case .badURL:
                print("❌ Error: \(String(describing: error))")
            case .iosDevloperIsStupid:
                print("❌ Error: \(String(describing: error))")
            case .none:
                print("noError")
            }
        }
        return detailDataSourceModel
    }
}
