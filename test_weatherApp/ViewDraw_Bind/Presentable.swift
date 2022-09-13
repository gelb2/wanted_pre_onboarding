//
//  Presentable.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import Foundation
import UIKit

protocol Presentable {
    func initViewHierarchy()
    func configureView()
    func bind()
}

protocol LoadingIndicatorPresentable {
    var activityIndicator: UIActivityIndicatorView { get set }
}
