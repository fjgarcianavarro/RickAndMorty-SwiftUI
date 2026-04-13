//
//  SearchCharactersUseCaseStub.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 13.04.2026.
//

import Foundation
@testable import RickAndMorty_SwiftUI

final class SearchCharactersUseCaseStub: SearchCharactersUseCaseType {
    private let result: Result<[CharacterEntity], CharacterDomainError>

    init(result: Result<[CharacterEntity], CharacterDomainError>) {
        self.result = result
    }

    func execute(name: String) async -> Result<[CharacterEntity], CharacterDomainError> {
        return result
    }
}
