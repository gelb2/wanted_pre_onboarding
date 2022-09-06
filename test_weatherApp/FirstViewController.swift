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
        
        let testURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=7f1a9a7368d6f22c077f8bef8d7a5200")
        let httpClient = HTTPClient()
        
        
        
        // Do any additional setup after loading the view.
    }


}

