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
        XCTAssertNil(result)
    }

    @MainActor func test_get_returnsCharacters_whenCacheIsValid() async {
        // GIVEN
        let sut = TTLInMemorySearchCacheDataSource(ttl: 60)
        let characters = CharacterEntityTestData.makeCharacterList()
        await sut.save(query: "rick", characters: characters)

        // WHEN
        let result = await sut.get(query: "rick")

        // THEN
        XCTAssertEqual(result, characters)
    }

    @MainActor func test_get_returnsNil_whenCacheHasExpired() async {
        // GIVEN
        let sut = TTLInMemorySearchCacheDataSource(ttl: 0)
        let characters = CharacterEntityTestData.makeCharacterList()
        await sut.save(query: "rick", characters: characters)

        // WHEN
        let result = await sut.get(query: "rick")

        // THEN
        XCTAssertNil(result)
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
        XCTAssertEqual(rickResult, rickCharacters)
        XCTAssertEqual(mortyResult, mortyCharacters)
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
        XCTAssertEqual(result, updatedCharacters)
    }

    @MainActor func test_get_normalizesQueryKey() async {
        // GIVEN
        let sut = TTLInMemorySearchCacheDataSource(ttl: 60)
        let characters = CharacterEntityTestData.makeCharacterList()
        await sut.save(query: "Rick", characters: characters)

        // WHEN
        let result = await sut.get(query: "  rick  ")

        // THEN
        XCTAssertEqual(result, characters)
    }
}
