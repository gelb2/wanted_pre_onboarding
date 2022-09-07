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
    
    //TODO: MVVM적으로, 이 모델이 컬렉션뷰를 컨트롤 하도록...
    var collectionViewModel: [BasicCollectionViewModel] = []
    
    //input
    var callBack = { }
    
    //output
    
    //TODO: 뷰모델에 주입할 제네릭한 클래스(레포지토리, 캐쉬, 스트링, 불 값 등 뷰모델에 필요한 것들 다 넣어줄 수 있는) 만들고 그 클래스를 주입받게끔 하기
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func populateData() {
        Task {
            await requestAPI()
            dataIsReadyToPresent()
        }
    }
    
    //TODO: model이 uikit에 대해 알고 있는건 좋지 못한듯 하다. DispatchQueue를 다른데로 빼야 한다
    private func dataIsReadyToPresent() {
        print("dataIsReady")
        
        callBack()
        
        
    }
    
    private func requestAPI() async {

        do {
            
            let timer = ParkBenchTimer()
            
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

            //TODO: http://openweathermap.org/img/w/10d.png
            //엔티티에서 받은 png 파일명 가지고 이미지URLString 만들기
            
            collectionViewModel = result.map { entity -> BasicCollectionViewModel in
                let weather = BasicCollectionViewModel()
                weather.cityName = entity.cityName
                weather.humid = entity.main.humidity
                weather.temp = entity.main.temp
                weather.icon = "http://openweathermap.org/img/w/10d.png"
                return weather
            }
            
            print("elapsed Time is \(timer.stop())")
            
            //TODO: 엔티티 --> 모델링 --> 콜렉션뷰 모델링 --> 뷰컨트롤러로 넘겨줌 --> 메인스레드에서 ui고칠 수 있도록 dispatchQueue.main을 하던 아니면 새로 나온 방법으로 하던...
            
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
