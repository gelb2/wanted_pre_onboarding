//
//  DetailViewControllerRoutable.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/12.
//

import Foundation
import UIKit


protocol DetailViewControllerRoutable: Routable, DetailViewControllerSceneBuildable, SceneDismissable { }

extension DetailViewControllerRoutable where Self: DetailViewController {
    func buildScene(scene: SceneCategory) -> Scenable? {
        var nextScene: Scenable?
        switch scene {
        case .alert(.networkAlert(.normalErrorAlert(let context))):
            nextScene = buildAlert(context: context)
        default: break
        }
        return nextScene
    }
    
    func route(to Scene: SceneCategory) {
        switch Scene {
        case .justClose:
            self.dismissScene(animated: true, completion: nil)
        default:
            guard let scene = buildScene(scene: Scene) else { return }
            guard let nextVC = scene as? UIViewController else { return }
            present(nextVC, animated: true, completion: nil)
        }
    }
}

protocol DetailViewControllerSceneBuildable: SceneBuildable {
    
}

extension DetailViewControllerSceneBuildable {

    func buildAlert(context: AlertDependency) -> Scenable {
        let nextScene: Scenable
        
        let alert = AlertFactory(dependency: context).createAlert()
        nextScene = alert
        return nextScene
    }
}
