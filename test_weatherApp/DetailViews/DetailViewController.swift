//
//  SecondViewController.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/06.
//

import UIKit

class DetailViewController: UIViewController {

    var contentView: DetailContentView
    var viewModel: DetailModel
    
    init(viewModel: DetailModel) {
        self.viewModel = viewModel
        self.contentView = DetailContentView(viewModel: self.viewModel.detailViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        initViewHierarchy()
        configureView()
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: Presentable {
    func initViewHierarchy() {
        self.view = UIView()

        view.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
    }
    
    
    func configureView() {
        self.view.backgroundColor = .white
    }
    
    func bind() {
        Task {
            viewModel.populateData()
        }
    }
}
