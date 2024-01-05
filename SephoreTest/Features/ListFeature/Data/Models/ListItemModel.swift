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

    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case productName = "product_name"
        case description
        case price
        case imagesUrl = "images_url"
        case cBrand = "c_brand"
        case isProductSet = "is_productSet"
        case isSpecialBrand = "is_special_brand"
    }
}

struct ImagesUrlModel: Decodable {
    let small: String
    let large: String
}

struct CBrandModel: Decodable {
    let id: String
    let name: String
}
