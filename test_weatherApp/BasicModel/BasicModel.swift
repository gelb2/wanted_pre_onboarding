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
    var contentViewModel: BasicContentViewModel {
        return privateContentViewModel
    }
    
    var searchViewModel: BasicSearchViewModel {
        return privateSearchViewModel
    }
    
    @MainThreadActor var routeSubject: ( (SceneCategory) -> () )?
    
    //properties
    private var privateContentViewModel: BasicContentViewModel
    private var privateSearchViewModel: BasicSearchViewModel
    private var repository: RepositoryProtocol

    init(repository: RepositoryProtocol) {
        self.repository = repository
        self.privateContentViewModel = BasicContentViewModel()
        self.privateSearchViewModel = BasicSearchViewModel()
        self.bind()
    }
    
    func bind() {
        privateContentViewModel.propergateDidSelectItem = { [weak self] cityName in
            
            let detailModel = DetailModel(repository: Repository(httpClient: HTTPClient()))
            detailModel.addMoreContext(cityName)
            let sceneContext = SceneContext(dependency: detailModel)
            
            self?.routeSubject?(.detail(.detailViewController(sceneContext)))
        }
        
        privateSearchViewModel.propergateFetchAllEvent = { [weak self] in
            self?.populateData()
        }
        
        privateSearchViewModel.propergateUserInput = { [weak self] userInput in
            self?.privateContentViewModel.didReceiveUserInput(userInput)
        }
        
        privateContentViewModel.userInputNotValid = { [weak self] userInput in
            guard let self = self else { return }
            
            let okAction = AlertActionDependency(title: "OK", style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.privateContentViewModel.turnOnIndicator?(())
                Task {
                    do {
                        async let entity: BasicWeatherEntity = self.repository.fetch(api: .weatherData(.cityName(name: userInput)))
                        let entities = try await [entity]
                        self.privateContentViewModel.didReceiveEntity(entities)
                        self.privateContentViewModel.turnOffIndicator?(())
                    } catch {
                        self.handleError(error: error)
                        self.privateContentViewModel.turnOffIndicator?(())
                    }
                }
            }
            
            let cancelAction = AlertActionDependency(title: "cancel", style: .cancel, action: nil)
            let alertDependency = AlertDependency(title: "???????????? ?????? ?????? ??????", message: "API??? ?????????????????????????", preferredStyle: .alert, actionSet: [okAction, cancelAction])
            self.routeSubject?(.alert(.basicViewAlert(.userSearchInputError(alertDependency))))
        }
    }

    func populateData() {
        Task {
            privateContentViewModel.turnOnIndicator?(())
            guard let entity = await requestAPI() else { return }
            privateContentViewModel.didReceiveEntity(entity)
            privateContentViewModel.turnOffIndicator?(())
        }
    }

    private func requestAPI() async -> [BasicWeatherEntity]? {
        //0.9???
        let timer = ParkBenchTimer()
        var closures: [(String, (String) -> Task<BasicWeatherEntity, Error>)] = []
        for value in CityNames.allCases {
            async let closure: (String) -> Task<BasicWeatherEntity, Error> = { (String) -> Task<BasicWeatherEntity, Error> in
                Task { () -> (BasicWeatherEntity) in
                    return try await self.repository.fetch(api: .weatherData(.cityName(name: value.rawValue)))
                }
            }
            await closures.append((value.rawValue, closure))
        }
        
        let mappedClosure = closures.map { value in value.1(value.0) }
        
        do {
            let asyncMapped: [BasicWeatherEntity] = try await mappedClosure.asyncMap { task in
                let result = try await task.result.get()
                return result
            }
            
            return asyncMapped
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
    /***************************************  depreactated ******************************************/
    private func deprecated1_requestAPI() async -> [BasicWeatherEntity]? {
        //3.7??? //Task??? ????????? ????????? ????????? ????????? ?????? ???????????? ?????????...?????? ??????????????????...
        let timer = ParkBenchTimer()

        let iteratedTask = Task { () -> [BasicWeatherEntity] in
            var entities: [BasicWeatherEntity] = []
            for try await value in Counter(cityNames: CityNames.allCases, repository: repository) {
                entities.append(value)
            }
            return entities
        }

        do {
            let result = try await iteratedTask.result.get()
            return result
        } catch {
            handleError(error: error)
            return nil
        }
    }
    
    private func deprecated2_requestAPI() async -> [BasicWeatherEntity]? {
        //3.5???
        do {
            
            let task = Task { () -> [BasicWeatherEntity] in
                var result: [BasicWeatherEntity] = []
                for value in CityNames.allCases {
                    async let entity: BasicWeatherEntity = try repository.fetch(api: .weatherData(.cityName(name: value.rawValue)))
                    try await result.append(entity)
                }
                return result
            }
            
            do {
                let result = try await task.result.get()
                return result
            } catch {
                handleError(error: error)
                return nil
            }
        } catch {
            handleError(error: error)
            return nil
        }
    }
    
    private func deprecated3_requestAPI() async -> [BasicWeatherEntity]? {
        //0.97???
        do {
            let timer = ParkBenchTimer()
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
}
