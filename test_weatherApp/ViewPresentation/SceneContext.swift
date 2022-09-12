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

//repository 같은 필수적으로 주입해야할 사항 이외의 다음 뷰에 필요한 string 같은것 주입시 사용...
protocol AdditionalContextAddable {
    
    associatedtype contextType
    
    var addMoreContext: (contextType) -> () { get set }
}
