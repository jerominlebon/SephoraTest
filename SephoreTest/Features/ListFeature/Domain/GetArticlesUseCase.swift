//
//  GetArticlesUseCase.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

protocol GetArticlesUseCaseProtocol {
    func execute() async -> Result<[ListItemModel], Error>
}

final class GetArticlesUseCase: GetArticlesUseCaseProtocol {
    private let listRepository: ListRepositoryProtocol

    init(listRepository: ListRepositoryProtocol = ListRepository()) {
        self.listRepository = listRepository
    }

    func execute() async -> Result<[ListItemModel], Error> {
        return await self.listRepository.getArticles()
    }
}
