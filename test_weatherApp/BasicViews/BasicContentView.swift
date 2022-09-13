//
//  BasicContentView.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/08.
//

import Foundation
import UIKit

class BasicContentView: UIView, BasicContentViewStyling, ActivityIndicatorViewStyling {
    
    //input
    
    //output
    var basicContentViewOutput = { }
    
    //properties
    private var viewModel: BasicContentViewModel
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private let layout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let reuseIdentifier = "BasicCell"
    
    
    init(viewModel: BasicContentViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        initViewHierarchy()
        configureView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension BasicContentView: LoadingIndicatorPresentable { }

extension BasicContentView: Presentable {
    func initViewHierarchy() {
        self.addSubview(collectionView)
        self.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        constraints += [
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
    }
    
    func configureView() {
        self.backgroundColor = .white
        collectionView.addStyles(style: collectionViewStyle)
        activityIndicator.addStyles(style: indicatorStyle)
        
        layout.addStyles(style: collectionViewFlowLayoutStyle)
    }
    
    func bind() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BasicCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        activityIndicator.startAnimating()
        
        viewModel.didReceiveViewModel = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

extension BasicContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BasicCell else {
            fatalError()
        }
        let model = viewModel.dataSource[indexPath.item]
        cell.configureCell(viewModel: model)
        return cell
    }
}

extension BasicContentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemInCollectionView(indexPath)
    }
}
