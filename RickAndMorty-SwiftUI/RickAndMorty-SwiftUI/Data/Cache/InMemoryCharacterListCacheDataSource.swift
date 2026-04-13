//
//  InMemoryCharacterListCacheDataSource.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 04.02.2025.
//

import Foundation

actor InMemoryCharacterListCacheDataSource: CharacterListCacheDataSourceType {
    private var cache: [CharacterEntity] = []
    
    func getCharacterList() async -> [CharacterEntity] {
        cache
    }
    
    func saveCharacterList(_ characterList: [CharacterEntity]) async {
        cache = characterList
    }
}
