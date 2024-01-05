//
//  ListDataSource.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

protocol ListDataSourceProtocol {
    func fetchArticles() async throws -> [ListItemModel]
}

final class ListDataSource: ListDataSourceProtocol {
    private let networkProvider: NetworkProviderProtocol
    private let cacheProvider: CacheProviderProtocol

    init(networkProvider: NetworkProviderProtocol = NetworkProvider.shared,
         cacheProvider: CacheProviderProtocol = CacheProvider.shared) {
        self.networkProvider = networkProvider
        self.cacheProvider = cacheProvider
    }

    func fetchArticles() async throws -> [ListItemModel] {
        let data = try await self.networkProvider.request(endpoint: .listing)

        guard let articles = try? JSONDecoder().decode([ListItemModel].self, from: data) else {
            throw NetworkError.serializing
        }

        self.cacheProvider.set(object: articles as AnyObject, for: Endpoint.listing.path)

        return articles
    }
}
