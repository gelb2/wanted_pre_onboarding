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
        
        //TODO: 다른 뷰 푸시 혹은 프리젠테이션 관련 처리 추가
        // TODO: 레포지토리, httpClient init을 여기가 아니라 모델 같은 다른 곳으로 옮겨서
        viewModel.routeSubject = { [weak self] in
            let sceneContext = SceneContext(dependency: DetailModel(repository: Repository(httpClient: HTTPClient())))
            self?.route(to: .detail(.detailViewController(sceneContext)))
        }
    }
}
