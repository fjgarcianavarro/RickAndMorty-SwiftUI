//
//  SearchCharactersUseCase.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 13.04.2026.
//

import Foundation

protocol SearchCharactersUseCaseType: Sendable {
    func execute(name: String) async -> Result<[CharacterEntity], CharacterDomainError>
}

final class SearchCharactersUseCase: SearchCharactersUseCaseType {
    private let repository: CharacterRepositoryType

    init(repository: CharacterRepositoryType) {
        self.repository = repository
    }

    func execute(name: String) async -> Result<[CharacterEntity], CharacterDomainError> {
        await repository.searchCharacters(name: name)
    }
}
