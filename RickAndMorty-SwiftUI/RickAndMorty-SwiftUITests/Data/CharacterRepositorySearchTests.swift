//
//  CharacterRepositorySearchTests.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José Navarro García on 13.04.2026.
//

import XCTest
@testable import RickAndMorty_SwiftUI

nonisolated final class CharacterRepositorySearchTests: XCTestCase {

    /// Verifies that `searchCharacters` returns cached results when search cache has a valid entry.
    @MainActor func test_searchCharacters_returnsCachedResult_whenCacheIsValid() async throws {
        // GIVEN
        let cachedCharacters = CharacterEntityTestData.makeCharacterList()
        let (sut, _, _) = makeSUT(remoteDataSourceResult: .success([]),
                                   searchCachedResult: cachedCharacters)

        // WHEN
        let result = await sut.searchCharacters(name: "rick")

        // THEN
        let capturedCharacters = try XCTUnwrap(result.get())
        XCTAssertEqual(capturedCharacters, cachedCharacters)
    }

    /// Verifies that `searchCharacters` calls the remote data source when cache is empty.
    @MainActor func test_searchCharacters_callsRemote_whenCacheIsEmpty() async throws {
        // GIVEN
        let expectedCharacters = CharacterEntityTestData.makeCharacterList()
        let (sut, _, _) = makeSUT(remoteDataSourceResult: .success(CharacterDTOTestData.makeCharacterList()),
                                   searchCachedResult: nil)

        // WHEN
        let result = await sut.searchCharacters(name: "rick")

        // THEN
        let capturedCharacters = try XCTUnwrap(result.get())
        XCTAssertEqual(capturedCharacters, expectedCharacters)
    }

    /// Verifies that `searchCharacters` saves fetched results into the search cache.
    @MainActor func test_searchCharacters_savesInCache_whenFetchedFromRemote() async throws {
        // GIVEN
        let expectedCharacters = CharacterEntityTestData.makeCharacterList()
        let (sut, _, searchCache) = makeSUT(remoteDataSourceResult: .success(CharacterDTOTestData.makeCharacterList()),
                                             searchCachedResult: nil)

        // WHEN
        _ = await sut.searchCharacters(name: "rick")

        // THEN
        let savedQuery = await searchCache.savedQuery
        let savedCharacters = await searchCache.savedCharacters
        XCTAssertEqual(savedQuery, "rick")
        XCTAssertEqual(savedCharacters, expectedCharacters)
    }

    /// Verifies that `searchCharacters` returns the correct error when the remote data source fails.
    @MainActor func test_searchCharacters_returnsError_whenRemoteFails() async {
        // GIVEN
        let (sut, _, _) = makeSUT(remoteDataSourceResult: .failure(.serverError),
                                   searchCachedResult: nil)

        // WHEN
        let result = await sut.searchCharacters(name: "rick")

        // THEN
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        XCTAssertEqual(error, .generic)
    }
}

extension CharacterRepositorySearchTests {
    @MainActor private func makeSUT(remoteDataSourceResult: Result<[CharacterDTO], HTTPClientError>,
                                     searchCachedResult: [CharacterEntity]?) -> (sut: CharacterRepository, cache: CharacterListCacheDataSourceStub, searchCache: SearchCacheDataSourceStub) {
        let remoteDataSource = CharacterListRemoteDataSourceStub(getCharacters: remoteDataSourceResult)
        let cacheDataSource = CharacterListCacheDataSourceStub(getCharacterList: [])
        let searchCacheDataSource = SearchCacheDataSourceStub(cachedResult: searchCachedResult)

        let sut = CharacterRepository(characterRemoteDataSource: remoteDataSource,
                                      domainMapper: CharacterDomainMapper(),
                                      errorMapper: CharacterDomainErrorMapper(),
                                      cacheDatasource: cacheDataSource,
                                      searchCache: searchCacheDataSource)

        return (sut, cacheDataSource, searchCacheDataSource)
    }
}
