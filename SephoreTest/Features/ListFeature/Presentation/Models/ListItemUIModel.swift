//
//  ListItemUIModel.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

struct ListItemUIModel {
    let productId: Int
    let productName: String
    let description: String
    let price: String
    let imagesUrl: ImagesUrlModel
    let cBrand: CBrandModel
    let isProductSet: Bool
    let isSpecialBrand: Bool
}
