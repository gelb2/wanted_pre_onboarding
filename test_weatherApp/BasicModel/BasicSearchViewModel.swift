//
//  BasicSearchViewModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/06.
//

import Foundation

//FirstVC에서 도시검색 용 텍스트필드 들어갈 뷰에 쓰일 뷰모델
class BasicSearchViewModel {
    
    //input
    var enterKeyPressed: (String) -> () = { userInput in }
    var fetchAllButtonPressed: () -> () = { }
    
    //output
    var propergateUserInput: (String) -> () = { userInput in }
    var propergateFetchAllEvent: () -> () = { }
    
    //properties
    init() {
        bind()
    }
    
    private func bind() {
        enterKeyPressed = { [weak self] userInput in
            self?.propergateUserInput(userInput)
        }
        
        fetchAllButtonPressed = { [weak self] in
            self?.propergateFetchAllEvent()
        }
    }
}
