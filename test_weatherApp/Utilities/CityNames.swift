//
//  CityNames.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/07.
//

import Foundation
//deprecated class for testing
class Counter: AsyncSequence {
    typealias Element = BasicWeatherEntity
    let cityNames: [CityNames]
    var repository: RepositoryProtocol
    
    init(cityNames: [CityNames], repository: RepositoryProtocol) {
        self.cityNames = cityNames
        self.repository = repository
    }
    
    class AsyncIterator: AsyncIteratorProtocol {
        
        let repository: RepositoryProtocol
        let howHigh: [CityNames]
        var current = 0
        
        init(repository: RepositoryProtocol, howHigh: [CityNames]) {
            self.repository = repository
            self.howHigh = howHigh
        }
        
        func next() async throws -> Element? {
            guard current < howHigh.count else {
                return nil
            }
            
            let value: BasicWeatherEntity = try await repository.fetch(api: .weatherData(.cityName(name: howHigh[current].rawValue)))
            current += 1
            return value
        }
    }
    
    func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator(repository: repository, howHigh: cityNames)
    }
}

enum CityNames: String, CaseIterable {

    case gongju
    case gwangju
    case gumi
    case gunsan
    case daegu
    case daejeon
    case mokpo
    case busan
    case seosan
    case seoul
    case sokcho
    case suwon
    case suncheon
    case ulsan
    case iksan
    case jeonju
    case jeju
    case cheonan
    case cheongju
    case chuncheon
    
    //temp testvalues
    case newyork = "new york"
    case london
    case berlin
    case sydney
    case tokyo
    case hongkong
    case moscow
    case hamburg
    case paris
    case madrid
    case rome
    case kiev
    case belgrade
    case osaka
    case daka
    case karachi
    case mumbai
    case prague
}
