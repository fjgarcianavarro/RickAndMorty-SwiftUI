//
//  CompositeCharacterListCacheDataSource.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 04.02.2025.
//

import Foundation

final class CompositeCharacterListCacheDataSource: CharacterListCacheDataSourceType {
    private let temporalCache: CharacterListCacheDataSourceType
    private let persistenceCache: CharacterListCacheDataSourceType

    init(temporalCache: CharacterListCacheDataSourceType, persistenceCache: CharacterListCacheDataSourceType) {
        self.temporalCache = temporalCache
        self.persistenceCache = persistenceCache
    }

    func getCharacterList() async -> [CharacterEntity] {
        let temporalCharacterList = await temporalCache.getCharacterList()

        if !temporalCharacterList.isEmpty {
            return temporalCharacterList
        }

        let persistenceCacheList = await persistenceCache.getCharacterList()
        await temporalCache.saveCharacterList(persistenceCacheList)

        return persistenceCacheList
    }

    func saveCharacterList(_ characterList: [CharacterEntity]) async {
        await temporalCache.saveCharacterList(characterList)
        await persistenceCache.saveCharacterList(characterList)
    }
}
