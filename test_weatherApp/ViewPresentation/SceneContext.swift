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

//TODO: SceneContext 클래스와 합치기? SceneContext와 같이 효과적으로 묶는 방법 생각해보기?
//기본적으로 모델에 주입할 repository, httpclient 이외의 프로퍼티, 파라미터들을 이걸 통해 주입받으면 좋지 않을까 함...
protocol AdditionalContextAddable {
    
    associatedtype contextType
    
    var addMoreContext: (contextType) -> () { get set }
}
