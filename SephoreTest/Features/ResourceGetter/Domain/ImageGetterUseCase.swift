//
//  ImageGetterUseCase.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

protocol ImageGetterUseCaseProtocol {
    func execute(with url: String) async -> Result<Data, Error>
}

final class ImageGetterUseCase: ImageGetterUseCaseProtocol {
    private let resourceGetterRepository: ResourceGetterRepositoryProtocol

    init(resourceGetterRepository: ResourceGetterRepositoryProtocol = ResourceGetterRepository()) {
        self.resourceGetterRepository = resourceGetterRepository
    }

    func execute(with url: String) async -> Result<Data, Error> {
        return await self.resourceGetterRepository.getImage(for: url)
    }
}
