//
//  DependencyContainer.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 12.04.2026.
//

import Foundation

final class DependencyContainer: Sendable {
    let characterImageCache: CharacterImageCacheType
    let inMemoryCharacterListCache: CharacterListCacheDataSourceType
    let inMemoryCharacterCache: CharacterCacheDataSourceType
    let searchCache: SearchCacheDataSourceType
    let characterListStorage: CharacterListStorageType
    let characterStorage: CharacterStorageType
    let storageDTOMapper: CharacterStorageDTOMapper

    init(characterImageCache: CharacterImageCacheType,
         inMemoryCharacterListCache: CharacterListCacheDataSourceType,
         inMemoryCharacterCache: CharacterCacheDataSourceType,
         searchCache: SearchCacheDataSourceType,
         characterListStorage: CharacterListStorageType,
         characterStorage: CharacterStorageType,
         storageDTOMapper: CharacterStorageDTOMapper) {
        self.characterImageCache = characterImageCache
        self.inMemoryCharacterListCache = inMemoryCharacterListCache
        self.inMemoryCharacterCache = inMemoryCharacterCache
        self.searchCache = searchCache
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
            searchCache: TTLInMemorySearchCacheDataSource(),
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
