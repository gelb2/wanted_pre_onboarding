//
//  +Extensions.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/09.
//

import Foundation

//TODO: 엔티티에서 받은 값을 수정하는게 좋을지 뷰모델에서 해주는게 좋을지 생각 좀 해보자...
//TODO: Sign이 정확한 Sign인지도 검증
extension String {
    func addTempratureSign() -> Self {
        let sign = "°C"
        let previousString = self
        return previousString + sign
    }
    
    func addPressureSign() -> Self {
        let sign = "hPa"
        let previousString = self
        return previousString + sign
    }
    
    func addHumiditySign() -> Self {
        let sign = "%"
        let previousString = self
        return previousString + sign
    }
    
    //㎧, knot, ㎞/hr
    func addWindSpeedSign() -> Self {
        let sign = "㎞/hr"
        let previousString = self
        return previousString + sign
    }
}

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
