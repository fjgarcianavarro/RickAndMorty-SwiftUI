//
//  CharacterRepositoryType.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 01.02.2025.
//

import Foundation

protocol CharacterRepositoryType: Sendable {
    func getCharacters() async -> Result<[CharacterEntity], CharacterDomainError>
    func searchCharacters(name: String) async -> Result<[CharacterEntity], CharacterDomainError>
}
