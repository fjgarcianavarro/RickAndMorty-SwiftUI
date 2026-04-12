//
//  PersistentCharacterCacheDataSource.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 15.02.2025.
//

import Foundation

final class PersistentCharacterCacheDataSource: CharacterCacheDataSourceType {
    private let storage: CharacterStorageType
    private let mapper: CharacterStorageDTOMapper

    init(storage: CharacterStorageType, mapper: CharacterStorageDTOMapper) {
        self.storage = storage
        self.mapper = mapper
    }

    func getCharacter(id: Int) async -> CharacterEntity? {
        guard let dto = await storage.fetchCharacter(id: id, isDetailed: true) else {
            return nil
        }
        return mapper.map(dto: dto)
    }

    func saveCharacter(character: CharacterEntity) async {
        let dto = mapper.map(entity: character, isDetailed: true)
        await storage.upsert(dto)
    }
}
