//
//  DependencyContainer.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 12.04.2026.
//

import Foundation

final class DependencyContainer {
    let characterImageCache: CharacterImageCacheType
    let inMemoryCharacterListCache: CharacterListCacheDataSourceType
    let inMemoryCharacterCache: CharacterCacheDataSourceType
    let characterListStorage: CharacterListStorageType
    let characterStorage: CharacterStorageType
    let storageDTOMapper: CharacterStorageDTOMapper

    init(characterImageCache: CharacterImageCacheType,
         inMemoryCharacterListCache: CharacterListCacheDataSourceType,
         inMemoryCharacterCache: CharacterCacheDataSourceType,
         characterListStorage: CharacterListStorageType,
         characterStorage: CharacterStorageType,
         storageDTOMapper: CharacterStorageDTOMapper) {
        self.characterImageCache = characterImageCache
        self.inMemoryCharacterListCache = inMemoryCharacterListCache
        self.inMemoryCharacterCache = inMemoryCharacterCache
        self.characterListStorage = characterListStorage
        self.characterStorage = characterStorage
        self.storageDTOMapper = storageDTOMapper
    }

    convenience init() {
        let dataStorageMapper = CharacterDataStorageMapper()
        self.init(
            characterImageCache: CharacterImageCache(),
            inMemoryCharacterListCache: InMemoryCharacterListCacheDataSource(),
            inMemoryCharacterCache: InMemoryCharacterCacheDataSource(),
            characterListStorage: CharacterListStorage(
                modelContainer: SharedModelContainer.instance,
                mapper: dataStorageMapper),
            characterStorage: CharacterStorage(
                modelContainer: SharedModelContainer.instance,
                mapper: dataStorageMapper),
            storageDTOMapper: CharacterStorageDTOMapper()
        )
    }
}
