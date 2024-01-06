//
//  SortSpecialBrandsUseCaseTests.swift
//  SephoreTestTests
//
//  Created by Jeromin Lebon on 06/01/2024.
//

import XCTest
@testable import SephoraTest

final class SortSpecialBrandsUseCaseTests: XCTestCase {
    let sortSpecialBrandsUseCase: SortSpecialBrandsUseCaseProtocol = SortSpecialBrandsUseCase()

    func testSortBySpecialBrands() throws {
        let items = [
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
            ),
            ListItemModel(
                productId: 2,
                productName: "MakeUp3",
                description: "This is a MakeUp3",
                price: 42,
                imagesUrl: ImagesUrlModel(small: "URL1", large: "URL2"),
                cBrand: CBrandModel(id: "cBrandID3", name: "Channel"),
                isProductSet: false,
                isSpecialBrand: true
            ),
            ListItemModel(
                productId: 3,
                productName: "MakeUp4",
                description: "This is a MakeUp4",
                price: 24,
                imagesUrl: ImagesUrlModel(small: "URL1", large: "URL2"),
                cBrand: CBrandModel(id: "cBrandID4", name: "Dior"),
                isProductSet: false,
                isSpecialBrand: false
            )
        ]
        let sortedArray = self.sortSpecialBrandsUseCase.execute(with: items)
        XCTAssertEqual(sortedArray[0].productId, 1)
        XCTAssertEqual(sortedArray[1].productId, 2)
        XCTAssertEqual(sortedArray[2].productId, 0)
        XCTAssertEqual(sortedArray[3].productId, 3)
    }
}
