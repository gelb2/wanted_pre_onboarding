//
//  +Extensions.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/09.
//

import Foundation
import UIKit

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

extension NSCache {
    @objc static var sharedCache: NSCache<AnyObject, AnyObject> {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 0  //unlimited. default
        cache.totalCostLimit = 0 //unlimited. default
        //sharedCache.totalCostLimit = 50 * 1024 * 1024 //50mb
        print("ns cache return called")
        return cache
    }
}

extension UIImage {
    convenience init?(systemName: ImageName) {
        self.init(systemName: systemName.rawValue)
    }
}

enum ImageName: String {
    case errorImage = "exclamationmark.circle.fill"
}
