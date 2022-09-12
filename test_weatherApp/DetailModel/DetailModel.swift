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
    var detailViewModel: DetailViewModel {
        return privateDetailViewModel
    }

    @MainThreadActor var routeSubject: ((SceneCategory) -> ())?
    
    //properties
    var privateDetailViewModel: DetailViewModel
    private let repository: RepositoryProtocol
    
    //일단 두번째 뷰가 전달받은 도시명 대로 api를 호출하는지 확인하는지 확인하고자 임의로 추가
    private var cityNameParam: String = ""

    init(repository: RepositoryProtocol) {
        self.repository = repository
        self.privateDetailViewModel = DetailViewModel()
        self.bind()
    }
    
    func bind() {
        addMoreContext = { [weak self] string in
            self?.cityNameParam = string
        }
        
        privateDetailViewModel.propergateDismissEvent = { [weak self] in
            self?.routeSubject?(.justClose)
        }
        
        privateDetailViewModel.propergateRandomEvent = { [weak self] in
            let detailModel = DetailModel(repository: Repository(httpClient: HTTPClient()))
            guard let cityName = self?.randomCityName() else { return }
            detailModel.addMoreContext(cityName)
            let sceneContext = SceneContext(dependency: detailModel)
            self?.routeSubject?(.detail(.detailViewController(sceneContext)))
        }
    }

    func populateData() {
        Task {
            guard let entity = await requestAPI() else { return }
            privateDetailViewModel.didReceiveEntity(entity)
        }
    }
    
    private func randomCityName() -> String {
        guard let cityName = CityNames.allCases.randomElement()?.rawValue else { return CityNames.seoul.rawValue }
        return cityName
    }

    private func requestAPI() async -> BasicWeatherEntity? {
        do {
            let result: BasicWeatherEntity = try await repository.fetch(api: .weatherData(.cityName(name: cityNameParam)))
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
