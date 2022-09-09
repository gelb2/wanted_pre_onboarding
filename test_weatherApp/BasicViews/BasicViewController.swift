//
//  ViewController.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/06.
//

import UIKit

class BasicViewController: UIViewController, BasicViewControllerRoutable {

    var viewModel: BasicModel
    var contentView: BasicContentView = BasicContentView()
    
    init(viewModel: BasicModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        initViewHierachy()
        configureView()
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension BasicViewController: Presentable {
    func initViewHierachy() {
        self.view = UIView()
        view.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }
    
    func configureView() {
        self.view.backgroundColor = .white
    }
    
    func bind() {
        Task {
            viewModel.populateData()
        }
        
        viewModel.didReceivedViewModel = { [weak self] contentViewModel in
            self?.contentView.didReceivedViewModel(contentViewModel)
        }
        
        viewModel.routeSubject = { [weak self] sceneCategory in
            //TODO: route는 다른 뷰를 푸시, 프리젠트 하게 되므로 메인스레드에서 돌아야 한다.
            //DispatchQueue를 여기에 박는 방법 이외에 더 깔끔한 방법을 찾아야 한다
            //ex. RxSwift.asDriver.drive 같이 메인스레드에서 UI수정을 위해 쓸 수 있는것 같은
            DispatchQueue.main.async {
                self?.route(to: sceneCategory)
            }
        }
    }
}
