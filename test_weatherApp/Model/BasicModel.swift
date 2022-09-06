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
        
        Task {
            await populateData()
        }
    }
    
    private func populateData() async {
        //TODO: url 영문 아닌 한글도 되도록 allowQuery옵션 추가
        guard let testURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=7f1a9a7368d6f22c077f8bef8d7a5200") else { return }
        
        do {
            let value: BasicWeatherEntity = try await repository.fetch(url: testURL)
            DispatchQueue.main.async {
                print(value)
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
            case .none:
                print("noError")
            }
        }
    }
}
