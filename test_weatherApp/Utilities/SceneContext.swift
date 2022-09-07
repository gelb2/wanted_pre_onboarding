//
//  SceneContext.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/06.
//

import Foundation

class SceneContext<Dependency> {
    var dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
}
