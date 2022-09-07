//
//  Routable.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/06.
//

import Foundation
import UIKit

protocol Scenable {
    
}

protocol SceneBuildable {
    func buildScene(scene: SceneCategory) -> Scenable?
}

protocol Routable {
    func route(to Scene: SceneCategory)
}

extension UIViewController: Scenable { }
