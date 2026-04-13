//
//  PersistentCharacterListCacheDataSource.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 04.02.2025.
//

import Foundation

final class PersistentCharacterListCacheDataSource: CharacterListCacheDataSourceType {
    private let storage: CharacterListStorageType
    private let mapper: CharacterStorageDTOMapper

    init(storage: CharacterListStorageType, mapper: CharacterStorageDTOMapper) {
        self.storage = storage
        self.mapper = mapper
    }

    func getCharacterList() async -> [CharacterEntity] {
        let dtos = await storage.fetchCharacters()
        return dtos.map { mapper.map(dto: $0) }
    }

    func saveCharacterList(_ characterList: [CharacterEntity]) async {
        let dtos = characterList.map { mapper.map(entity: $0) }
        await storage.insert(dtos)
    }
}
