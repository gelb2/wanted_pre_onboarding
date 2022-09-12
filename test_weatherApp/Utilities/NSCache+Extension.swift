//
//  ImageCache.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/08.
//

import Foundation
//TODO: Init이 여러번 불리는데 이거 수정필요...
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
