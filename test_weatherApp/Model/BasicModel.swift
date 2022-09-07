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
            //TODO: API 분석하여 한글 도시명 받아도 처리 가능하도록 개선
            let value: BasicWeatherEntity = try await repository.fetch(api: .weatherData(.cityName(name: "seoul")))
            let value2: BasicWeatherEntity = try await repository.fetch(api: .weatherData(.cityName(name: "busan")))
            let value3: BasicWeatherEntity = try await repository.fetch(api: .weatherData(.cityName(name: "daegu")))
            let value4: BasicWeatherEntity = try await repository.fetch(api: .weatherData(.cityName(name: "seosan")))
            let value5: BasicWeatherEntity = try await repository.fetch(api: .weatherData(.cityName(name: "sokcho")))
            let value6: BasicWeatherEntity = try await repository.fetch(api: .weatherData(.cityName(name: "suwon")))
            testArray.append(value)
            testArray.append(value2)
            testArray.append(value3)
            testArray.append(value4)
            testArray.append(value5)
            testArray.append(value6)
            
            print("testARray check")
            print(testArray.count)
            print("testARray check end")
            
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
