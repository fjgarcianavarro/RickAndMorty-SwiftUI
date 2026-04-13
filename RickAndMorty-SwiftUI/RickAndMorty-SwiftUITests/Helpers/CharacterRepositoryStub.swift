//
//  CharacterRepositoryStub.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 06.02.2025.
//

import Foundation
@testable import RickAndMorty_SwiftUI

final class CharacterRepositoryStub: CharacterRepositoryType {
    private let result: Result<[CharacterEntity], CharacterDomainError>
    
    init(result: Result<[CharacterEntity], CharacterDomainError>) {
        self.result = result
    }
    
    func getCharacters() async -> Result<[CharacterEntity], CharacterDomainError> {
        result
    }

    func searchCharacters(name: String) async -> Result<[CharacterEntity], CharacterDomainError> {
        result
    }
}
