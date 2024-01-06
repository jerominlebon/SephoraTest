//
//  ListViewModelTests.swift
//  SephoreTestTests
//
//  Created by Jeromin Lebon on 06/01/2024.
//

import XCTest
@testable import SephoraTest

final class ListViewModelTests: XCTestCase {
    var listViewModel: ListViewModel!
    var listRepository: ListRepositoryProtocol!
    var getItemsUseCase: GetItemsUseCaseProtocol!
    var mock = ListDataSourceMock()

    override func setUpWithError() throws {
        self.listRepository = ListRepository(listDataSource: self.mock, shouldUseCache: false)
        self.getItemsUseCase = GetItemsUseCase(listRepository: self.listRepository)
        self.listViewModel = ListViewModel(getItemsUseCase: self.getItemsUseCase)

        self.mock.fetchedItems = [
            ListItemModel(
                productId: 0,
                productName: "MakeUp",
                description: "This is a MakeUp",
                price: 42,
                imagesUrl: ImagesUrlModel(small: "URL1", large: "URL2"),
                cBrand: CBrandModel(id: "cBrandID1", name: "Channel"),
                isProductSet: false,
                isSpecialBrand: false
            ),
            ListItemModel(
                productId: 1,
                productName: "MakeUp2",
                description: "This is a MakeUp2",
                price: 24,
                imagesUrl: ImagesUrlModel(small: "URL1", large: "URL2"),
                cBrand: CBrandModel(id: "cBrandID2", name: "Dior"),
                isProductSet: false,
                isSpecialBrand: true
            )
        ]
    }

    override func tearDownWithError() throws {
        self.mock.fetchedItems = []
        self.mock.isFetchedItemsInError = false
    }

    func testDataMapping() async throws {
        self.listViewModel.reloadTableViewClosure = { [weak self] in
            XCTAssertEqual(self?.listViewModel.items.count, 2)
            XCTAssertEqual(self?.listViewModel.items[0], ListItemUIModel(
                productId: 1,
                productName: "MakeUp2",
                description: "This is a MakeUp2",
                price: "24 €",
                imagesUrl: ImagesUrlModel(small: "URL1", large: "URL2"),
                cBrand: CBrandModel(id: "cBrandID2", name: "Dior"),
                isProductSet: false,
                isSpecialBrand: true
            ))
            XCTAssertEqual(self?.listViewModel.items[1], ListItemUIModel(
                productId: 0,
                productName: "MakeUp",
                description: "This is a MakeUp",
                price: "42 €",
                imagesUrl: ImagesUrlModel(small: "URL1", large: "URL2"),
                cBrand: CBrandModel(id: "cBrandID1", name: "Channel"),
                isProductSet: false,
                isSpecialBrand: false
            ))
        }

        await self.listViewModel.getItems()
    }

    func testErrorRetrievingDatas() async {
        self.mock.isFetchedItemsInError = true
        self.listViewModel.didGetErrorClosure = { [weak self] in
            XCTAssertEqual(self?.listViewModel.items.count, 0)
        }

        await self.listViewModel.getItems()
    }
}
