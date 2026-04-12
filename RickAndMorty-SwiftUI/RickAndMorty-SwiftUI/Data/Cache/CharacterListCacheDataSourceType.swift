//
//  CharacterListCacheDataSourceType.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 04.02.2025.
//

import Foundation

protocol CharacterListCacheDataSourceType: Sendable {
    func getCharacterList() async -> [CharacterEntity]
    func saveCharacterList(_ characterList: [CharacterEntity]) async
}
