//
//  BasicSearchView.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/13.
//

import UIKit
import SwiftUI

class BasicSearchView: UIView, BasicSearchViewStyling {

    //input
    
    //output
    
    //properties
    private var viewModel: BasicSearchViewModel
    
    let horizontalStackView = UIStackView()
    var textField: UITextField = UITextField()
    var fetchAllButton: UIButton = UIButton()
    
    init(viewModel: BasicSearchViewModel) {
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

extension BasicSearchView: Presentable {
    func initViewHierarchy() {
        
        self.addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(textField)
        horizontalStackView.addArrangedSubview(fetchAllButton)
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        fetchAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
    }
    
    func configureView() {
        self.addStyles(style: contentViewStyle)
        horizontalStackView.addStyles(style: horizontalStackViewStyle)
        textField.addStyles(style: textFieldStyle)
        fetchAllButton.addStyles(style: fetchAllButtonStyle)
    }
    
    func bind() {
        textField.delegate = self
        fetchAllButton.addTarget(self, action: #selector(fetchAllButtonPressed), for: .touchUpInside)
    }
    
    @objc private func fetchAllButtonPressed() {
        viewModel.fetchAllButtonPressed()
    }
}

extension BasicSearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("enterkey pressed")
        guard let textInput = textField.text else { return true }
        viewModel.enterKeyPressed(textInput)
        textField.resignFirstResponder()
        return true
    }
}

#if canImport(SwiftUI) && DEBUG
struct BasicSearchViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    // MARK: UIViewRepresentable
    func makeUIView(context: Context) -> some UIView {
        view
    }
    // MARK: UIViewRepresentable
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#endif

#if canImport(SwiftUI) && DEBUG
struct BasicSearchViewPreviewProvider: PreviewProvider {
    static var previews: some View {
        BasicSearchViewPreview {
            let cell = BasicSearchView(viewModel: BasicSearchViewModel())
            
            return cell
        }.previewLayout(.fixed(width: 100, height:100))
    }
}

#endif
