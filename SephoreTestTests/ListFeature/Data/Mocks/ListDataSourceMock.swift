//
//  ListDataSourceMock.swift
//  SephoreTestTests
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation
@testable import SephoreTest

class ListDataSourceMock: ListDataSourceProtocol {
    var isFetchedItemsInError = false
    var fetchedItems: [ListItemModel] = []
    func fetchItems() async throws -> [SephoreTest.ListItemModel] {
        if isFetchedItemsInError {
            throw NetworkError.serializing
        }
        return fetchedItems
    }
}
