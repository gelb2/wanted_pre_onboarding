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

    //TODO: 뷰모델에 주입할 제네릭한 클래스(레포지토리, 캐쉬, 스트링, 불 값 등 뷰모델에 필요한 것들 다 넣어줄 수 있는) 만들고 그 클래스를 주입받게끔 하기
    init(repository: RepositoryProtocol) {
        self.repository = repository
        self.privateDetailViewModel = DetailViewModel()
        self.bind()
    }
    
    func bind() {
        addMoreContext = { [weak self] string in
            self?.cityNameParam = string
        }
    }

    func populateData() {
        Task {
            guard let entity = await requestAPI() else { return }
            privateDetailViewModel.didReceiveEntity(entity)
        }
    }

    private func requestAPI() async -> BasicWeatherEntity? {
        do {
            let result: BasicWeatherEntity = try await repository.fetch(api: .weatherData(.cityName(name: cityNameParam)))
            return result
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
            return nil
        }
    }
}
