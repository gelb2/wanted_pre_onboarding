//
//  PropertyWrappers.swift
//  test_weatherApp
//
//  Created by sokol on 2022/09/10.
//

import Foundation

//해당 프로퍼티 어트리뷰트가 추가된 넘들은 메인스레드에서 구동될 것을 보장케 하고자 추가
//사실 애플이 이미 @MainActor를 만들었긴 하나 본 기능수정, 버그픽스 사항에서 도입하기엔 너무 큰 건인것 같다.
//TODO: 프로퍼티래퍼의 MainThreadActor 수정 후 추가
//Scene을 받는 클로저에선 문제가 없었는데 Void 인 클로저를 받으니 아예 엑스코드가 에러내용도 못잡고 빌드도 안된다
@propertyWrapper
struct MainThreadActor<T> {
    var closure: ((T) -> ())?
    
    var wrappedValue: ((T) -> ())? {
        get {
            return { value in
                DispatchQueue.main.async {
                    closure?(value)
                }
            }
        }
        
        set {
            closure = newValue
        }
    }
}
