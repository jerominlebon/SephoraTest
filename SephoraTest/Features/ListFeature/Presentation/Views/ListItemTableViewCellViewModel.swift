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

    private let imageGetterUseCase: ImageGetterUseCaseProtocol

    init(item: ListItemUIModel,
         imageGetterUseCase: ImageGetterUseCaseProtocol = ImageGetterUseCase()) {
        self.item = item
        self.imageGetterUseCase = imageGetterUseCase
    }

    func getImage() {
        Task {
            await self.getItemImage()
        }
    }

    @MainActor
    private func getItemImage() async {
        let response = await self.imageGetterUseCase.execute(with: item.imagesUrl.small)
        switch response {
        case .success(let imageData):
            didFetchImageClosure?(imageData)
        case .failure:
            didFetchImageClosure?(nil)
        }
    }
}
