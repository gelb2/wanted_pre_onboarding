//
//  Routable.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/06.
//

import Foundation
import UIKit

// TODO: 뷰프리젠테이션 관련 로직 추가 처리
//얼럿 팝업, dismiss 등
protocol Scenable {
    
}

protocol SceneBuildable {
    func buildScene(scene: SceneCategory) -> Scenable?
}

protocol Routable {
    func route(to Scene: SceneCategory)
}

extension UIViewController: Scenable { }
