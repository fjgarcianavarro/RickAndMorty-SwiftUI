//
//  TTLInMemorySearchCacheDataSourceTests.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José García Navarro on 13.04.2026.
//

import XCTest
@testable import RickAndMorty_SwiftUI

nonisolated final class TTLInMemorySearchCacheDataSourceTests: XCTestCase {

    @MainActor func test_get_returnsNil_whenCacheIsEmpty() async {
        // GIVEN
        let sut = TTLInMemorySearchCacheDataSource()

        // WHEN
        let result = await sut.get(query: "rick")

        // THEN
        XCTAssertNil(result, "Empty cache should return nil for any query")
    }

    @MainActor func test_get_returnsCharacters_whenCacheIsValid() async {
        // GIVEN
        let sut = TTLInMemorySearchCacheDataSource(ttl: 60)
        let characters = CharacterEntityTestData.makeCharacterList()
        await sut.save(query: "rick", characters: characters)

        // WHEN
        let result = await sut.get(query: "rick")

        // THEN
        XCTAssertEqual(result, characters, "Valid cache entry should return saved characters")
    }

    @MainActor func test_get_returnsNil_whenCacheHasExpired() async {
        // GIVEN
        let sut = TTLInMemorySearchCacheDataSource(ttl: 0)
        let characters = CharacterEntityTestData.makeCharacterList()
        await sut.save(query: "rick", characters: characters)

        // WHEN
        let result = await sut.get(query: "rick")

        // THEN
        XCTAssertNil(result, "Expired cache entry should return nil")
    }

    @MainActor func test_get_differentQueriesAreIndependent() async {
        // GIVEN
        let sut = TTLInMemorySearchCacheDataSource(ttl: 60)
        let rickCharacters = [CharacterEntityTestData.makeCharacterList()[0]]
        let mortyCharacters = [CharacterEntityTestData.makeCharacterList()[1]]
        await sut.save(query: "rick", characters: rickCharacters)
        await sut.save(query: "morty", characters: mortyCharacters)

        // WHEN
        let rickResult = await sut.get(query: "rick")
        let mortyResult = await sut.get(query: "morty")

        // THEN
        XCTAssertEqual(rickResult, rickCharacters, "Rick query should return rick characters independently")
        XCTAssertEqual(mortyResult, mortyCharacters, "Morty query should return morty characters independently")
    }

    @MainActor func test_save_overwritesPreviousEntry() async {
        // GIVEN
        let sut = TTLInMemorySearchCacheDataSource(ttl: 60)
        let originalCharacters = CharacterEntityTestData.makeCharacterList()
        let updatedCharacters = [CharacterEntityTestData.makeCharacterList()[0]]
        await sut.save(query: "rick", characters: originalCharacters)

        // WHEN
        await sut.save(query: "rick", characters: updatedCharacters)
        let result = await sut.get(query: "rick")

        // THEN
        XCTAssertEqual(result, updatedCharacters, "Saving with the same query should overwrite the previous entry")
    }

    @MainActor func test_get_normalizesQueryKey() async {
        // GIVEN
        let sut = TTLInMemorySearchCacheDataSource(ttl: 60)
        let characters = CharacterEntityTestData.makeCharacterList()
        await sut.save(query: "Rick", characters: characters)

        // WHEN
        let result = await sut.get(query: "  rick  ")

        // THEN
        XCTAssertEqual(result, characters, "Query lookup should be case-insensitive and trim whitespace")
    }
}
