//
//  BasicModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/06.
//

import Foundation

//FirstViewController용 모델
class BasicModel {
    
    //input
    
    //output
    var didReceivedViewModel: (_ viewModel: BasicCollectionViewModel) -> () = { viewModel in }
    var routeSubject: (SceneCategory) -> () = { SceneCategory in }
    
    //properties
    private var basicViewModel: BasicCollectionViewModel
    private var repository: RepositoryProtocol

    //TODO: 뷰모델에 주입할 제네릭한 클래스(레포지토리, 캐쉬, 스트링, 불 값 등 뷰모델에 필요한 것들 다 넣어줄 수 있는) 만들고 그 클래스를 주입받게끔 하기
    init(repository: RepositoryProtocol) {
        self.repository = repository
        self.basicViewModel = BasicCollectionViewModel()
        self.bind()
    }
    
    func bind() {
        basicViewModel.propergateDidSelectItem = { [weak self] cityName in
            
            let detailModel = DetailModel(repository: Repository(httpClient: HTTPClient()))
            detailModel.addMoreContext(cityName)
            let sceneContext = SceneContext(dependency: detailModel)
            
            self?.routeSubject(.detail(.detailViewController(sceneContext)))
        }
    }

    func populateData() {
        Task {
            let dataSource = await requestAPI()
            basicViewModel.didReceivedDataSource(dataSource)
            didReceivedViewModel(basicViewModel)
        }
    }

    private func requestAPI() async -> [BasicCellViewModel] {
        var dataSource: [BasicCellViewModel] = []
        do {
            //TODO: API 분석하여 한글 도시명 받아도 처리 가능하도록 개선 -> 일단 addPercentEncoding(.query) 는 안되는 것으로 확인
            //TODO: 비동기 로직들을 다 동기로 돌리니 느림...개선해야 함...개선중임...그냥 enum 루프 돌리는 것 보단 빠르다 시간 재보니...
                        
            async let gongju: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.gongju.rawValue)))
            async let gwangu: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.gwangju.rawValue)))
            async let gumi: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.gumi.rawValue)))
            async let gunsan: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.gunsan.rawValue)))
            async let daegu: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.daegu.rawValue)))
            async let daejeon: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.daejeon.rawValue)))
            async let mokpo: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.mokpo.rawValue)))
            async let busan: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.busan.rawValue)))
            async let seosan: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.seosan.rawValue)))
            async let seoul: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.seoul.rawValue)))
            async let sokcho: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.sokcho.rawValue)))
            async let suwon: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.suwon.rawValue)))
            async let suncheon: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.suncheon.rawValue)))
            async let ulsan: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.ulsan.rawValue)))
            async let iksan: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.iksan.rawValue)))
            async let jeonju: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.jeonju.rawValue)))
            async let jeju: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.jeju.rawValue)))
            async let cheonan: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.cheonan.rawValue)))
            async let cheongju: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.cheongju.rawValue)))
            async let chuncheon: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: CityNames.chuncheon.rawValue)))

            let result = try await [gongju,gwangu,gumi,gunsan,daegu,daejeon,mokpo,busan,seosan,seoul,sokcho,suwon,suncheon,ulsan,iksan,jeonju,jeju,cheonan,cheongju,chuncheon]

            dataSource = result.map { entity -> BasicCellViewModel in
                let weather = BasicCellViewModel()
                weather.cityName = entity.cityName
                weather.humid = entity.main.humidity
                weather.temp = entity.main.temp
                
                //TODO: 서버 api에서 weather는 배열이다...왜지...도큐먼트를 봐도 확실한 설명이 없어 보인다...
                weather.icon = entity.weather.first?.icon ?? ""
                return weather
            }
        } catch {
            handleError(error: error)
        }
        return dataSource
    }
    
    private func handleError(error: Error) {
        
        let error = error as? HTTPError
        
        switch error {
        case .invalidURL, .errorDecodingData, .badResponse, .badURL, .iosDevloperIsStupid:
            let okAction = AlertActionDependency(title: "ok", style: .default, action: nil)
            let cancelAction = AlertActionDependency(title: "cancel", style: .cancel, action: nil)
            let alertDependency = AlertDependency(title: String(describing: error), message: "check network", preferredStyle: .alert, actionSet: [okAction, cancelAction])
            routeSubject(.alert(.networkAlert(.normalErrorAlert(alertDependency))))
        case .none:
            break
        }
    }

}
