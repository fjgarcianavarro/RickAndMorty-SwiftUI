//
//  PersistentCharacterListCacheDataSourceTests.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José García Navarro on 08.02.2025.
//

import XCTest
@testable import RickAndMorty_SwiftUI

nonisolated final class PersistentCharacterListCacheDataSourceTests: XCTestCase {
    /// Ensures that `getCharacterList` returns an empty array when there is no cached data.
    @MainActor func test_getCharacterList_returns_empty_when_storage_is_empty() async {
        // GIVEN
        let storageStub = CharacterListStorageStub(fetchCharactersResult: [])
        let sut = makeSUT(storageStub)

        // WHEN
        let result = await sut.getCharacterList()

        // THEN
        XCTAssertEqual(result, [], "Empty storage should return empty character list")
    }

    /// Ensures that `getCharacterList` correctly maps stored `CharacterStorageDTO` into `CharacterEntity`.
    @MainActor func test_getCharacterList_correctly_maps_stored_data_to_entities() async {
        // GIVEN
        let storedDTOs = CharacterStorageDTOTestData.makeCharacterList()
        let expectedEntities = CharacterEntityTestData.makeCharacterList()

        let storageStub = CharacterListStorageStub(fetchCharactersResult: storedDTOs)
        let sut = makeSUT(storageStub)

        // WHEN
        let result = await sut.getCharacterList()

        // THEN
        XCTAssertEqual(result, expectedEntities, "Stored DTOs should be correctly mapped to domain entities")
    }

    /// Ensures that `saveCharacterList` correctly handles an empty list without errors.
    @MainActor func test_saveCharacterList_saves_empty_list_in_persistent_storage() async {
        // GIVEN
        let emptyCharacterList: [CharacterEntity] = []
        let storageStub = CharacterListStorageStub(fetchCharactersResult: [])

        let sut = makeSUT(storageStub)

        // WHEN
        await sut.saveCharacterList(emptyCharacterList)

        // THEN
        let insertedCount = await storageStub.insertedCharacters.count
        XCTAssertEqual(insertedCount, 0, "Saving an empty list should not insert any characters")
    }
}

extension PersistentCharacterListCacheDataSourceTests {
    @MainActor private func makeSUT(_ characterListStorage: CharacterListStorageType) -> CharacterListCacheDataSourceType {
        PersistentCharacterListCacheDataSource(storage: characterListStorage,
                                               mapper: CharacterStorageDTOMapper())
    }
}
