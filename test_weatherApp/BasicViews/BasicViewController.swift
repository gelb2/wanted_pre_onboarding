//
//  ViewController.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/06.
//

import UIKit

class BasicViewController: UIViewController, BasicViewControllerRoutable {

    var viewModel: BasicModel
    lazy var contentView: BasicContentView = BasicContentView(viewModel: self.viewModel.contentViewModel)
    lazy var searchView: BasicSearchView = BasicSearchView(viewModel: self.viewModel.searchViewModel)
    
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
        self.view = UIView()
        self.view.addSubview(contentView)
        self.view.addSubview(searchView)
        self.title = "City Weathers"
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            searchView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 36)
        ]
        
        constraints += [
            contentView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ]
    }
    
    func configureView() {
        self.view.backgroundColor = .white
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
