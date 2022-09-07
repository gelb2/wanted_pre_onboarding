//
//  ViewController.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/06.
//

import UIKit

class BasicViewController: UIViewController {

    //TODO: 뷰컨 init때 뷰모델 주입 받도록 하기
    var viewModel: BasicModel
    
    //TODO: 컬렉션뷰만 들고 있을 UIView 추가 후 거기에서 추가작업 진행. 지금은 일단 임의로 vc에 붙임
    private let layout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let reuseIdentifier = "BasicCell"
    private let cellSpacing: CGFloat = 1
    private let columns: CGFloat = 3
    
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
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }
    
    func configureView() {
        self.view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        let width = (UIScreen.main.bounds.width - cellSpacing * 2) / columns
        layout.itemSize = CGSize(width: width , height: width)
    }
    
    func bind() {
//        collectionView.dataSource = self
        collectionView.register(BasicCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        viewModel.populateData()
    }
}

//extension BasicViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//    }
//}
//
//extension BasicViewController: UICollectionViewDelegate {
//    
//}
