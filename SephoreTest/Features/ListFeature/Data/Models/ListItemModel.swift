//
//  ListItemModel.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

struct ListItemModel: Decodable {
    let productId: Int
    let productName: String
    let description: String
    let price: Int
    let imagesUrl: ImagesUrlModel
    let cBrand: CBrandModel
    let isProductSet: Bool
    let isSpecialBrand: Bool
}

struct ImagesUrlModel: Decodable {
    let small: String
    let large: String
}

struct CBrandModel: Decodable {
    let id: String
    let name: String
}
