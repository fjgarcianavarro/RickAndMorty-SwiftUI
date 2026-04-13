//
//  CompositeCharacterListCacheDataSourceTests.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José García Navarro on 06.02.2025.
//

import XCTest
@testable import RickAndMorty_SwiftUI

nonisolated final class CompositeCharacterListCacheDataSourceTests: XCTestCase {
    /// Ensures that `getCharacterList` returns a non-empty array when the temporal cache contains data.
    @MainActor func test_getCharacterList_returns_non_empty_array_when_there_is_temporal_cache() async {
        // GIVEN
        let characterList = CharacterEntityTestData.makeCharacterList()
        let temporalCache = CharacterListCacheDataSourceStub(getCharacterList: characterList)
        let persistenceCache = CharacterListCacheDataSourceStub(getCharacterList: [])
        
        let sut = CompositeCharacterListCacheDataSource(temporalCache: temporalCache,
                                                        persistenceCache: persistenceCache)
        
        // WHEN
        let capturedResult = await sut.getCharacterList()
        
        // THEN
        XCTAssertEqual(capturedResult, characterList, "Should return data from temporal cache when available")
    }

    /// Ensures that `getCharacterList` fetches from the persistence cache when the temporal cache is empty.
    @MainActor func test_getCharacterList_returns_non_empty_array_when_temporal_is_empty_and_there_is_persistence_cache() async {
        // GIVEN
        let characterList = CharacterEntityTestData.makeCharacterList()
        let temporalCache = CharacterListCacheDataSourceStub(getCharacterList: [])
        let persistenceCache = CharacterListCacheDataSourceStub(getCharacterList: characterList)
        
        let sut = CompositeCharacterListCacheDataSource(temporalCache: temporalCache,
                                                        persistenceCache: persistenceCache)
        
        // WHEN
        let capturedResult = await sut.getCharacterList()
        
        // THEN
        XCTAssertEqual(capturedResult, characterList, "Should fall back to persistence cache when temporal cache is empty")
    }

    /// Ensures that `getCharacterList` returns an empty array when both caches are empty.
    @MainActor func test_getCharacterList_returns_empty_array_when_temporal_and_persistence_caches_are_empty() async {
        // GIVEN
        let temporalCache = CharacterListCacheDataSourceStub(getCharacterList: [])
        let persistenceCache = CharacterListCacheDataSourceStub(getCharacterList: [])
        
        let sut = CompositeCharacterListCacheDataSource(temporalCache: temporalCache,
                                                        persistenceCache: persistenceCache)
        
        // WHEN
        let capturedResult = await sut.getCharacterList()
        
        // THEN
        XCTAssertEqual(capturedResult, [], "Should return empty array when both caches are empty")
    }

    /// Ensures that when fetching from the persistence cache, the retrieved data is saved in the temporal cache.
    @MainActor func test_getCharacterList_saves_in_temporal_cache_when_temporal_is_empty_and_there_is_persistence_cache() async {
        // GIVEN
        let characterList = CharacterEntityTestData.makeCharacterList()
        let temporalCache = CharacterListCacheDataSourceStub(getCharacterList: [])
        let persistenceCache = CharacterListCacheDataSourceStub(getCharacterList: characterList)
        
        let sut = CompositeCharacterListCacheDataSource(temporalCache: temporalCache,
                                                        persistenceCache: persistenceCache)
        
        // WHEN
        _ = await sut.getCharacterList()
        
        // THEN
        let temporalCached = await temporalCache.cachedCharacterList
        XCTAssertEqual(temporalCached, characterList, "Persistence cache data should be saved in temporal cache for future access")
    }

    /// Ensures that `saveCharacterList` stores the list in both the temporal and persistence caches.
    @MainActor func test_saveCharacterList_saves_in_temporal_and_persistence_cache() async {
        // GIVEN
        let characterList = CharacterEntityTestData.makeCharacterList()
        let temporalCache = CharacterListCacheDataSourceStub(getCharacterList: [])
        let persistenceCache = CharacterListCacheDataSourceStub(getCharacterList: [])
        
        let sut = CompositeCharacterListCacheDataSource(temporalCache: temporalCache,
                                                        persistenceCache: persistenceCache)
        
        // WHEN
        await sut.saveCharacterList(characterList)
        
        // THEN
        let temporalCached = await temporalCache.cachedCharacterList
        let persistenceCached = await persistenceCache.cachedCharacterList
        XCTAssertEqual(temporalCached, characterList, "Character list should be saved in temporal cache")
        XCTAssertEqual(persistenceCached, characterList, "Character list should be saved in persistence cache")
    }

    /// Ensures that `saveCharacterList` stores an empty list in both the temporal and persistence caches.
    @MainActor func test_saveCharacterList_saves_empty_array_in_temporal_and_persistence_cache() async {
        // GIVEN
        let emptyCharacterList: [CharacterEntity] = []
        let temporalCache = CharacterListCacheDataSourceStub(getCharacterList: [])
        let persistenceCache = CharacterListCacheDataSourceStub(getCharacterList: [])
        
        let sut = CompositeCharacterListCacheDataSource(temporalCache: temporalCache,
                                                        persistenceCache: persistenceCache)
        
        // WHEN
        await sut.saveCharacterList(emptyCharacterList)
        
        // THEN
        let temporalCached = await temporalCache.cachedCharacterList
        let persistenceCached = await persistenceCache.cachedCharacterList
        XCTAssertEqual(temporalCached, [], "Empty list should be saved in temporal cache")
        XCTAssertEqual(persistenceCached, [], "Empty list should be saved in persistence cache")
    }

    /// Ensures that `getCharacterList` returns data from the persistence cache when the temporal cache is empty.
    @MainActor func test_getCharacterList_returns_persistence_cache_only_when_temporal_cache_is_empty() async {
        // GIVEN
        let persistenceCharacterList = CharacterEntityTestData.makeCharacterList()
        
        let temporalCache = CharacterListCacheDataSourceStub(getCharacterList: [])
        let persistenceCache = CharacterListCacheDataSourceStub(getCharacterList: persistenceCharacterList)
        
        let sut = CompositeCharacterListCacheDataSource(temporalCache: temporalCache,
                                                        persistenceCache: persistenceCache)
        
        // WHEN
        let capturedResult = await sut.getCharacterList()
        
        // THEN
        XCTAssertEqual(capturedResult, persistenceCharacterList, "Should return persistence cache data when temporal cache is empty")
    }
}
