//
//  ResourceGetterRepository.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

protocol ResourceGetterRepositoryProtocol {
    func getImage(for url: String) async -> Result<Data, Error>
}

final class ResourceGetterRepository: ResourceGetterRepositoryProtocol {
    private let cacheProvider: CacheProviderProtocol
    private let resourceGetterDataSource: ResourceGetterDataSourceProtocol

    init(cacheProvider: CacheProviderProtocol = CacheProvider.shared, resourceGetterDataSource: ResourceGetterDataSourceProtocol = ResourceGetterDataSource()) {
        self.cacheProvider = cacheProvider
        self.resourceGetterDataSource = resourceGetterDataSource
    }

    func getImage(for url: String) async -> Result<Data, Error> {
        if let data = self.cacheProvider.get(path: url) as? Data {
            return .success(data)
        } else {
            do {
                let data = try await self.resourceGetterDataSource.downloadImage(with: url)
                return .success(data)
            } catch {
                return .failure(error)
            }
        }
    }
}
