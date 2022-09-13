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
    case justClose
    
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
            case userSearchInputError(AlertDependency)
        }
        
        enum detailViewRelated {
            case notDefinedYet 
        }
        
    }
}
