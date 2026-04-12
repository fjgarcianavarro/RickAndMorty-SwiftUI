//
//  CompositeCharacterCacheDataSource.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 15.02.2025.
//

import Foundation

final class CompositeCharacterCacheDataSource: CharacterCacheDataSourceType {
    private let temporalCache: CharacterCacheDataSourceType
    private let persistenceCache: CharacterCacheDataSourceType

    init(temporalCache: CharacterCacheDataSourceType, persistenceCache: CharacterCacheDataSourceType) {
        self.temporalCache = temporalCache
        self.persistenceCache = persistenceCache
    }

    func getCharacter(id: Int) async -> CharacterEntity? {
        if let temporalCharacter = await temporalCache.getCharacter(id: id) {
            return temporalCharacter
        }

        guard let persistedCharacter = await persistenceCache.getCharacter(id: id) else {
            return nil
        }

        await temporalCache.saveCharacter(character: persistedCharacter)

        return persistedCharacter
    }

    func saveCharacter(character: CharacterEntity) async {
        await temporalCache.saveCharacter(character: character)
        await persistenceCache.saveCharacter(character: character)
    }
}
