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
    
    //output
    var propergateUserInput: (String) -> () = { userInput in }
    
    //properties
    init() {
        bind()
    }
    
    private func bind() {
        enterKeyPressed = { [weak self] userInput in
            guard let filteredInput = self?.removeSpaces(userInput: userInput) else { return }
            self?.propergateUserInput(filteredInput)
        }
    }
    
    private func removeSpaces(userInput: String) -> String {
        return userInput.replacingOccurrences(of: " ", with: "")
    }
    
}
