//
//  GetArticleUseCaseTests.swift
//  SephoreTestTests
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import XCTest
@testable import SephoreTest

final class GetArticleUseCaseTests: XCTestCase {
    var mock = ListDataSourceMock()
    lazy var listRepository = ListRepository(listDataSource: mock)
    lazy var getArticleUseCase: GetArticlesUseCaseProtocol = GetArticlesUseCase(listRepository: listRepository)

    override func setUpWithError() throws {
        mock.fetchedArticles = [
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
        mock.fetchedArticles = []
    }

    func testFetchArticles() async throws {
        let articles = try await self.getArticleUseCase.execute().get()

        XCTAssert(articles.count == 2)
        XCTAssertEqual(articles[0].productId, 0)
        XCTAssertEqual(articles[0].productName, "MakeUp")
        XCTAssertEqual(articles[0].description, "This is a MakeUp")
        XCTAssertEqual(articles[0].price, 42)
        XCTAssertEqual(articles[0].imagesUrl.small, "URL1")
        XCTAssertEqual(articles[0].imagesUrl.large, "URL2")
        XCTAssertEqual(articles[0].cBrand.id, "cBrandID1")
        XCTAssertEqual(articles[0].cBrand.name, "Channel")
        XCTAssertFalse(articles[0].isProductSet)
        XCTAssertFalse(articles[0].isSpecialBrand)

        XCTAssertEqual(articles[1].productId, 1)
        XCTAssertEqual(articles[1].productName, "MakeUp2")
        XCTAssertEqual(articles[1].description, "This is a MakeUp2")
        XCTAssertEqual(articles[1].price, 24)
        XCTAssertEqual(articles[1].imagesUrl.small, "URL1")
        XCTAssertEqual(articles[1].imagesUrl.large, "URL2")
        XCTAssertEqual(articles[1].cBrand.id, "cBrandID2")
        XCTAssertEqual(articles[1].cBrand.name, "Dior")
        XCTAssertFalse(articles[1].isProductSet)
        XCTAssertTrue(articles[1].isSpecialBrand)
    }
}
