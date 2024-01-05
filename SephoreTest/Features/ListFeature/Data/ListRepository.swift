//
//  ListRepository.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

protocol ListRepositoryProtocol {
    func getItems() async -> Result<[ListItemModel], Error>
}

final class ListRepository: ListRepositoryProtocol {
    private let cacheProvider: CacheProviderProtocol
    private let listDataSource: ListDataSourceProtocol

    init(cacheProvider: CacheProviderProtocol = CacheProvider.shared,
         listDataSource: ListDataSourceProtocol = ListDataSource()) {
        self.cacheProvider = cacheProvider
        self.listDataSource = listDataSource
    }

    func getItems() async -> Result<[ListItemModel], Error> {
        if let data = self.cacheProvider.get(path: Endpoint.listing.path) as? [ListItemModel] {
            return .success(data)
        } else {
            do {
                let data = try await self.listDataSource.fetchItems()
                return .success(data)
            } catch {
                return .failure(error)
            }
        }
    }
}
