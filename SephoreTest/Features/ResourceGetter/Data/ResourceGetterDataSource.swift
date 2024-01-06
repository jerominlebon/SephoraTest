//
//  ResourceGetterDataSource.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

protocol ResourceGetterDataSourceProtocol {
    func downloadImage(with url: String) async throws -> Data
}

final class ResourceGetterDataSource: ResourceGetterDataSourceProtocol {
    private let networkProvider: NetworkProviderProtocol
    private let cacheProvider: CacheProviderProtocol

    init(networkProvider: NetworkProviderProtocol = NetworkProvider.shared,
         cacheProvider: CacheProviderProtocol = CacheProvider.shared) {
        self.networkProvider = networkProvider
        self.cacheProvider = cacheProvider
    }

    func downloadImage(with url: String) async throws -> Data {
        let data = try await self.networkProvider.request(endpoint: .images(url))
        self.cacheProvider.set(object: data as AnyObject, for: url)
        return data
    }
}
