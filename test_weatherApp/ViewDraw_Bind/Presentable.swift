//
//  Presentable.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import Foundation
import UIKit

protocol Presentable {
    func initViewHierachy()
    func configureView()
    func bind()
}
