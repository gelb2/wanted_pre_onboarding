//
//  Routable.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/06.
//

import Foundation
import UIKit

// TODO: 뷰프리젠테이션 관련 로직 추가 처리
//dismiss 시키는 처리, navigationController와 조합시키기, dismiss 시키고 이전 뷰의 밸류가 바뀌도록 해보기 혹은 이전 뷰가 다른 동작을 하게끔 해보기
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
