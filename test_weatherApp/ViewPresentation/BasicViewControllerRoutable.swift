//
//  BasicViewControllerRoutable.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/08.
//

import Foundation
import UIKit

protocol BasicViewControllerRoutable: Routable, BasicViewControllerSceneBuildable { }

extension BasicViewControllerRoutable where Self: BasicViewController {
    func buildScene(scene: SceneCategory) -> Scenable? {
        var nextScene: Scenable?
        switch scene {
        case .detail(.detailViewController(let context)):
            nextScene = buildDetailViewScene(context: context)
        default: break
        }
        return nextScene
    }
    
    func route(to Scene: SceneCategory) {
        guard let scene = buildScene(scene: Scene) else { return }
        guard let nextVC = scene as? UIViewController else { return }
        present(nextVC, animated: true, completion: nil)
    }
}

protocol BasicViewControllerSceneBuildable: SceneBuildable {
    
}

extension BasicViewControllerSceneBuildable {
    func buildDetailViewScene(context: SceneContext<DetailModel>) -> Scenable {
        let nextScene: Scenable
        
        let detailModel = context.dependency
        let detailVC = DetailViewController(viewModel: detailModel)
        nextScene = detailVC
        return nextScene
    }
}