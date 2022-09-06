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
        guard let testURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=7f1a9a7368d6f22c077f8bef8d7a5200") else { return }
        
        do {
            let httpClient = HTTPClient()
            let value: FirstViewModel = try await httpClient.fetch(url: testURL)
            
            DispatchQueue.main.async {
                print(value)
            }
        } catch {
            print("❌ Error: \(error)")
        }
    }


}

