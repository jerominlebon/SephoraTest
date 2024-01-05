//
//  ListDataSourceMock.swift
//  SephoreTestTests
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation
@testable import SephoreTest

class ListDataSourceMock: ListDataSourceProtocol {
    var isFetchedArticlesInError = false
    var fetchedArticles: [ListItemModel] = []
    func fetchArticles() async throws -> [SephoreTest.ListItemModel] {
        if isFetchedArticlesInError {
            throw NetworkError.serializing
        }
        return fetchedArticles
    }
}
