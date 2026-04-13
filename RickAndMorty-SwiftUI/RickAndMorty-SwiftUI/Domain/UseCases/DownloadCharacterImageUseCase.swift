//
//  DownloadCharacterImageUseCase.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 09.02.2025.
//

import Foundation

protocol DownloadCharacterImageUseCaseType: Sendable {
    func execute(url: URL) async -> Result<Data, CharacterImageError>
}

final class DownloadCharacterImageUseCase: DownloadCharacterImageUseCaseType {
    private let repository: CharacterImageRepositoryType

    init(repository: CharacterImageRepositoryType) {
        self.repository = repository
    }

    func execute(url: URL) async -> Result<Data, CharacterImageError> {
        let result = await repository.getImage(for: url)
        
        guard let characterImage = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.unknown)
            }

            return .failure(error)
        }
        
        return .success(characterImage)
    }
}
