//
//  ViewController.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/06.
//

import UIKit

class FirstViewController: UIViewController {

    override func loadView() {
        self.view = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
        Task {
            await test()
        }
        // Do any additional setup after loading the view.
    }
    
    func test() async {
        
        //TODO: url 영문 아닌 한글도 되도록 allowQuery옵션 추가
        
        guard let testURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=7f1a9a7368d6f22c077f8bef8d7a5200") else { return }
        
        do {
            let httpClient = HTTPClient()
            let value: BasicWeatherEntity = try await httpClient.fetch(url: testURL)
            
            DispatchQueue.main.async {
                print(value)
            }
        } catch {
            //TODO: 뷰모델이 에러 핸들링 하게 하기
            let error = error as? HTTPError
            switch error {
            case .invalidURL:
                print("❌ Error: \(error)")
            case .errorDecodingData:
                print("❌ Error: \(error)")
            case .badResponse:
                print("❌ Error: \(error)")
            case .badURL:
                print("❌ Error: \(error)")
            case .none:
                print("noError")
            }
        }
    }


}

