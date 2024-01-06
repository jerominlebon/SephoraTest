//
//  ListDataSourceMock.swift
//  SephoreTestTests
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation
@testable import SephoraTest

class ListDataSourceMock: ListDataSourceProtocol {
    var isFetchedItemsInError = false
    var fetchedItems: [ListItemModel] = []
    func fetchItems() async throws -> [SephoraTest.ListItemModel] {
        if isFetchedItemsInError {
            throw NetworkError.serializing
        }
        return fetchedItems
    }
}
