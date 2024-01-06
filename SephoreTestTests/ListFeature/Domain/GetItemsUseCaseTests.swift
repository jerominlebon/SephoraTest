//
//  GetItemsUseCaseTests.swift
//  SephoreTestTests
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import XCTest
@testable import SephoreTest

final class GetItemsUseCaseTests: XCTestCase {
    var mock = ListDataSourceMock()
    var listRepository: ListRepositoryProtocol!
    var getItemsUseCase: GetItemsUseCaseProtocol!

    override func setUpWithError() throws {
        self.listRepository = ListRepository(listDataSource: self.mock)
        self.getItemsUseCase = GetItemsUseCase(listRepository: self.listRepository)

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
    }

    func testFetchArticles() async throws {
        let items = try await self.getItemsUseCase.execute().get()

        XCTAssert(items.count == 2)
        XCTAssertEqual(items[0].productId, 0)
        XCTAssertEqual(items[0].productName, "MakeUp")
        XCTAssertEqual(items[0].description, "This is a MakeUp")
        XCTAssertEqual(items[0].price, 42)
        XCTAssertEqual(items[0].imagesUrl.small, "URL1")
        XCTAssertEqual(items[0].imagesUrl.large, "URL2")
        XCTAssertEqual(items[0].cBrand.id, "cBrandID1")
        XCTAssertEqual(items[0].cBrand.name, "Channel")
        XCTAssertFalse(items[0].isProductSet)
        XCTAssertFalse(items[0].isSpecialBrand)

        XCTAssertEqual(items[1].productId, 1)
        XCTAssertEqual(items[1].productName, "MakeUp2")
        XCTAssertEqual(items[1].description, "This is a MakeUp2")
        XCTAssertEqual(items[1].price, 24)
        XCTAssertEqual(items[1].imagesUrl.small, "URL1")
        XCTAssertEqual(items[1].imagesUrl.large, "URL2")
        XCTAssertEqual(items[1].cBrand.id, "cBrandID2")
        XCTAssertEqual(items[1].cBrand.name, "Dior")
        XCTAssertFalse(items[1].isProductSet)
        XCTAssertTrue(items[1].isSpecialBrand)
    }
}
