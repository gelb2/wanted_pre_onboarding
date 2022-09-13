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

protocol SceneDismissable {
    func dismissScene(animated: Bool, completion: (() -> Void)?)
}

extension SceneDismissable where Self: UIViewController {
    func dismissScene(animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animated, completion: completion)
    }
}

extension UIViewController: Scenable { }
