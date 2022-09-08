//
//  BasicContentView.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/08.
//

import Foundation
import UIKit

class BasicContentView: UIView {
    
    //input
    var didReceivedViewModel: (_: BasicCollectionViewModel) -> () = { viewModel in }
    
    //output
    var basicContentViewOutput = { }
    
    //properties
    private var viewModel: BasicCollectionViewModel = BasicCollectionViewModel()
    
    private let layout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let reuseIdentifier = "BasicCell"
    private let cellSpacing: CGFloat = 1
    private let columns: CGFloat = 3
    
    init() {
        super.init(frame: .zero)
        initViewHierachy()
        configureView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension BasicContentView: Presentable {
    func initViewHierachy() {
        self.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
    }
    
    //TODO: CollectionView layout 수정
    //셀 더 크게 만들자...
    func configureView() {
        self.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        let width = (UIScreen.main.bounds.width - cellSpacing * 2) / columns
        layout.itemSize = CGSize(width: width , height: width)
    }
    
    func bind() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BasicCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        didReceivedViewModel = { [weak self] model in
            self?.viewModel = model
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

//TODO: collectionViewModel과의 연관 로직 개선
extension BasicContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BasicCell else {
            fatalError()
        }
        
        cell.cellView.cityNameLabel.text = viewModel.dataSource[indexPath.item].cityName
        cell.cellView.humidityLabel.text = String(viewModel.dataSource[indexPath.item].humid)
        cell.cellView.temperatureLabel.text = String(viewModel.dataSource[indexPath.item].temp)
        
        let imageUrlString = viewModel.dataSource[indexPath.item].icon
        cell.cellView.iconImageView.loadImage(urlString: imageUrlString)
        return cell
    }
}

extension BasicContentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemInCollectionView(indexPath)
    }
}
