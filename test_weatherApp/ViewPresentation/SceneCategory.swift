//
//  SceneCategory.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/06.
//

import Foundation

//앱이 타고 들어가야 할 VC를 enum화
enum SceneCategory {
    case main(mainScene)
    case detail(detailScene)
    case alert(alertScene)
    
    enum mainScene {
        case basicViewController(SceneContext<BasicModel>)
    }
    
    enum detailScene {
        case detailViewController(SceneContext<DetailModel>)
    }
    
    enum alertScene {
        case networkAlert(networkError)
        case basicViewAlert(basicViewRelated)
        
        enum networkError {
            case normalErrorAlert(AlertDependency)
        }
        
        enum basicViewRelated {
            case moveToDetailView(AlertDependency)
        }
        
        enum detailViewRelated {
            case notDefinedYet //TODO: 두번째 VC, VM에 어느 기능을 추가로 넣어야 할지 고려해보기
        }
        
    }
}
