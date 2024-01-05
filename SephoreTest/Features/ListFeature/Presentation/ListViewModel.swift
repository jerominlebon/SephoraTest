//
//  ListViewModel.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

final class ListViewModel {
    private var items: [ListItemUIModel] = []
    var cellViewModels: [ListItemTableViewCellViewModel] = [] {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var reloadTableViewClosure: (() -> ())?
    var didGetErrorClosure: (() -> ())?
    private let getItemsUseCase: GetItemsUseCaseProtocol

    init(getItemsUseCase: GetItemsUseCaseProtocol = GetItemsUseCase()) {
        self.getItemsUseCase = getItemsUseCase
    }

    func initViewModel() {
        Task {
            await getItems()
        }
    }

    @MainActor
    private func getItems() async {
        Task {
            let response = await self.getItemsUseCase.execute()
            switch response {
            case .success(let items):
                self.items = mapToUI(data: items)
                self.mapToViewModels(items: self.items)
            case .failure:
                self.didGetErrorClosure?()
            }
        }
    }

    private func mapToUI(data: [ListItemModel]) -> [ListItemUIModel] {
        data.map { item in
            ListItemUIModel(
                productId: item.productId,
                productName: item.productName,
                description: item.description,
                price: "\(item.price) €",
                imagesUrl: item.imagesUrl,
                cBrand: item.cBrand,
                isProductSet: item.isProductSet,
                isSpecialBrand: item.isSpecialBrand
            )
        }
    }

    private func mapToViewModels(items: [ListItemUIModel]) {
        self.cellViewModels = items.map { ListItemTableViewCellViewModel(item: $0) }
    }
}
