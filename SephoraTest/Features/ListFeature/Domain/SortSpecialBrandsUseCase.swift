//
//  SortSpecialBrandsUseCase.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

protocol SortSpecialBrandsUseCaseProtocol {
    func execute(with items: [ListItemModel]) -> [ListItemModel]
}

final class SortSpecialBrandsUseCase: SortSpecialBrandsUseCaseProtocol {
    func execute(with items: [ListItemModel]) -> [ListItemModel] {
        return items.sorted { $0.isSpecialBrand && !$1.isSpecialBrand }
    }
}
