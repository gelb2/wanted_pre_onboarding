//
//  SecondViewController.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/06.
//

import UIKit

class DetailViewController: UIViewController {

    lazy var contentView: DetailContentView = DetailContentView(viewModel: self.viewModel.detailViewModel)
    var viewModel: DetailModel
    
    init(viewModel: DetailModel) {
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
        self.view = contentView
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
