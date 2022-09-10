//
//  ViewController.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/06.
//

import UIKit

class BasicViewController: UIViewController, BasicViewControllerRoutable {

    var viewModel: BasicModel
    lazy var contentView: BasicContentView = BasicContentView(viewModel: self.viewModel.collectionViewModel)
    
    init(viewModel: BasicModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        initViewHierarchy()
        configureView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        // Do any additional setup after loading the view.
    }
}

extension BasicViewController: Presentable {
    func initViewHierarchy() {
        self.view = contentView
    }
    
    func configureView() {
        self.view.backgroundColor = .red
    }
    
    func bind() {
        Task {
            viewModel.populateData()
        }

        viewModel.routeSubject = { [weak self] sceneCategory in
            self?.route(to: sceneCategory)
        }
    }
}
