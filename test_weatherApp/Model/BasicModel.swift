//
//  BasicModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/06.
//

import Foundation

//FirstViewController용 모델
class BasicModel {
    
    var repository: RepositoryProtocol
    
    //TODO: 뷰모델에 주입할 제네릭한 클래스(레포지토리, 캐쉬, 스트링, 불 값 등 뷰모델에 필요한 것들 다 넣어줄 수 있는) 만들고 그 클래스를 주입받게끔 하기
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func populateData() {
        Task {
            await populateData()
        }
    }
    
    private func populateData() async {

        do {
            
            //TODO: http://openweathermap.org/img/w/10d.png
            //엔티티에서 받은 png 파일명 가지고 이미지URLString 만들기
            
            var testArray: [BasicWeatherEntity] = []
            //TODO: API 분석하여 한글 도시명 받아도 처리 가능하도록 개선 -> 일단 addPercentEncoding(.query) 는 안되는 것으로 확인
            //TODO: 비동기 로직들을 다 동기로 돌리니 느림...개선해야 함
            let value: BasicWeatherEntity = try await repository.fetch(api: .weatherData(.cityName(name: "seoul")))
            
            for city in CityNames.allCases {
                print("city name : \(city)")
                let value: BasicWeatherEntity = try await repository.fetch(api: .weatherData(.cityName(name: city.rawValue)))
                testArray.append(value)
                print("city name appended: \(city)")
            }
            
            DispatchQueue.main.async {
                print("viewModelData begin")
                print(value)
                print("viewModelData end")
            }
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
    }
}
