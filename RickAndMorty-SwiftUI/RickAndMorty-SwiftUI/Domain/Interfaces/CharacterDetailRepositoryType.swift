//
//  CharacterDetailRepositoryType.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 12.02.2025.
//

import Foundation

protocol CharacterDetailRepositoryType: Sendable {
    func getCharacterDetail(id: String) async -> Result<CharacterEntity, CharacterDomainError>
}
