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
    
    var textField: UITextField = UITextField()
    
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
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
    }
    
    func configureView() {
        textField.addStyles(style: textFieldStyle)
    }
    
    func bind() {
        textField.delegate = self
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
