//
//  BasicModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/06.
//

import Foundation

class BasicModel {
    
    //input
    
    //output
    var collectionViewModel: BasicCollectionViewModel {
        return privateCollectionViewModel
    }
    
    @MainThreadActor var routeSubject: ( (SceneCategory) -> () )?
    
    //properties
    private var privateCollectionViewModel: BasicCollectionViewModel
    private var repository: RepositoryProtocol

    //TODO: 뷰모델에 주입할 제네릭한 클래스(레포지토리, 캐쉬, 스트링, 불 값 등 뷰모델에 필요한 것들 다 넣어줄 수 있는) 만들고 그 클래스를 주입받게끔 하기
    init(repository: RepositoryProtocol) {
        self.repository = repository
        self.privateCollectionViewModel = BasicCollectionViewModel()
        self.bind()
    }
    
    func bind() {
        privateCollectionViewModel.propergateDidSelectItem = { [weak self] cityName in
            
            let detailModel = DetailModel(repository: Repository(httpClient: HTTPClient()))
            detailModel.addMoreContext(cityName)
            let sceneContext = SceneContext(dependency: detailModel)
            
            self?.routeSubject?(.detail(.detailViewController(sceneContext)))
        }
    }

    func populateData() {
        Task {
            guard let entity = await requestAPI() else { return }
            privateCollectionViewModel.didReceiveEntity(entity)
        }
    }

    private func requestAPI() async -> [BasicWeatherEntity]? {
        do {
            //TODO: API 분석하여 한글 도시명 받아도 처리 가능하도록 개선 -> 일단 addPercentEncoding(.query) 는 안되는 것으로 확인
            //TODO: 비동기 로직들을 다 동기로 돌리니 느림...개선해야 함...개선중임...그냥 enum 루프 돌리는 것 보단 빠르다 시간 재보니...async let 방식으로 메소드를 돌리는 것과 루프를 돌리는것 둘다 가능하게 수정해보자...
                        
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
            return result
        } catch {
            handleError(error: error)
            return nil
        }
    }
    
    private func handleError(error: Error) {
        
        let error = error as? HTTPError
        
        switch error {
        case .invalidURL, .errorDecodingData, .badResponse, .badURL, .iosDevloperIsStupid:
            let okAction = AlertActionDependency(title: "ok", style: .default, action: nil)
            let cancelAction = AlertActionDependency(title: "cancel", style: .cancel, action: nil)
            let alertDependency = AlertDependency(title: String(describing: error), message: "check network", preferredStyle: .alert, actionSet: [okAction, cancelAction])
            routeSubject?(.alert(.networkAlert(.normalErrorAlert(alertDependency))))
        case .none:
            break
        }
    }

}
