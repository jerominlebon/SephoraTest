//
//  ListItemTableViewCellViewModel.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

final class ListItemTableViewCellViewModel {
    let item: ListItemUIModel
    var didFetchImageClosure: ((Data?) -> ())?

    init(item: ListItemUIModel) {
        self.item = item
    }
}
