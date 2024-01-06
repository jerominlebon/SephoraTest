//
//  CacheProvider.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

protocol CacheProviderProtocol {
    func set(object: AnyObject, for path: String)
    func get(path: String) -> AnyObject?
}

final class CacheProvider: CacheProviderProtocol {
    public static let shared = CacheProvider()
    private let cache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()

    func set(object: AnyObject, for path: String) {
        self.cache.setObject(object, forKey: path as AnyObject)
    }

    func get(path: String) -> AnyObject? {
        let cachedObject = self.cache.object(forKey: path as AnyObject)
        return cachedObject
    }
}
