//
//  CharacterListViewModelTests.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José García Navarro on 13.04.2026.
//

import Combine
import XCTest
@testable import RickAndMorty_SwiftUI

nonisolated final class CharacterListViewModelTests: XCTestCase {

    // MARK: - fetchCharacters

    /// Ensures that fetchCharacters populates the characters array on success.
    @MainActor func test_fetchCharacters_populatesCharacters_onSuccess() async {
        // GIVEN
        let expectedCharacters = CharacterEntityTestData.makeCharacterList()
        let sut = makeSUT(getAllResult: .success(expectedCharacters))

        // WHEN
        await sut.fetchCharacters()

        // THEN
        XCTAssertEqual(sut.characters.count, 3, "Characters count should match the expected list from the use case")
        XCTAssertEqual(sut.characters[0].name, "Rick Sanchez", "First character should be Rick Sanchez")
        XCTAssertFalse(sut.loading, "Loading should be false after fetching completes")
    }

    /// Ensures that fetchCharacters shows an alert on error.
    @MainActor func test_fetchCharacters_showsAlert_onError() async {
        // GIVEN
        let sut = makeSUT(getAllResult: .failure(.generic))

        // WHEN
        await sut.fetchCharacters()

        // THEN
        XCTAssertTrue(sut.showAlert, "Alert should be shown when fetchCharacters fails")
        XCTAssertTrue(sut.characters.isEmpty, "Characters should remain empty on error")
        XCTAssertFalse(sut.loading, "Loading should be false after error is handled")
    }

    // MARK: - onSearchTextChanged (empty query)

    /// Ensures that an empty query reloads all characters.
    @MainActor func test_onSearchTextChanged_withEmptyQuery_reloadsAllCharacters() async {
        // GIVEN
        let expectedCharacters = CharacterEntityTestData.makeCharacterList()
        let sut = makeSUT(getAllResult: .success(expectedCharacters))

        // WHEN
        sut.onSearchTextChanged("")
        await Task.yield()
        await Task.yield()

        // THEN
        XCTAssertEqual(sut.characters.count, 3, "Empty query should reload all characters from getAllCharactersUseCase")
    }

    // MARK: - onSearchTextChanged (with query)

    /// Ensures that a search query returns matching results.
    @MainActor func test_onSearchTextChanged_withQuery_returnsSearchResults() async {
        // GIVEN
        let searchCharacters = CharacterEntityTestData.makeCharacterList()
        let sut = makeSUT(searchResult: .success(searchCharacters))

        // WHEN
        sut.onSearchTextChanged("rick")
        await awaitPublishedChange(sut)

        // THEN
        XCTAssertEqual(sut.characters.count, 3, "Search results count should match the search use case response")
        XCTAssertEqual(sut.characters[0].name, "Rick Sanchez", "First search result should be Rick Sanchez")
        XCTAssertFalse(sut.loading, "Loading should be false after search completes")
    }

    /// Ensures that a search error shows an alert.
    @MainActor func test_onSearchTextChanged_withQuery_showsAlert_onSearchError() async {
        // GIVEN
        let sut = makeSUT(searchResult: .failure(.generic))

        // WHEN
        sut.onSearchTextChanged("rick")
        await awaitPublishedChange(sut)

        // THEN
        XCTAssertTrue(sut.showAlert, "Alert should be shown when search fails")
        XCTAssertTrue(sut.characters.isEmpty, "Characters should remain empty on search error")
    }

    /// Ensures that a search returning no results shows an empty list without an alert.
    @MainActor func test_onSearchTextChanged_withQuery_returnsEmptyResults() async {
        // GIVEN
        let sut = makeSUT(searchResult: .success([]))

        // WHEN
        sut.onSearchTextChanged("nonexistent")
        await awaitPublishedChange(sut)

        // THEN
        XCTAssertTrue(sut.characters.isEmpty, "Characters should be empty when search returns no results")
        XCTAssertFalse(sut.loading, "Loading should be false after empty search completes")
        XCTAssertFalse(sut.showAlert, "Alert should not be shown for empty but successful search")
    }

    // MARK: - refreshData

    /// Ensures that refreshData reloads the characters list.
    @MainActor func test_refreshData_reloadsCharacters() async {
        // GIVEN
        let expectedCharacters = CharacterEntityTestData.makeCharacterList()
        let sut = makeSUT(getAllResult: .success(expectedCharacters))

        // WHEN
        await sut.refreshData()

        // THEN
        XCTAssertEqual(sut.characters.count, 3, "Characters count should match after refresh")
        XCTAssertFalse(sut.loading, "Loading should be false after refresh completes")
    }

    // MARK: - Cancellation

    /// Ensures that rapid consecutive searches cancel previous ones, only the last search produces a result.
    @MainActor func test_onSearchTextChanged_cancellation_onlyLastSearchProducesResult() async {
        // GIVEN
        let successCharacters = CharacterEntityTestData.makeCharacterList()
        let sut = makeSUT(searchResult: .success(successCharacters))

        // WHEN — two rapid searches, the first gets cancelled
        sut.onSearchTextChanged("ric")
        sut.onSearchTextChanged("rick")
        await awaitPublishedChange(sut)

        // THEN — only the last search produces a result
        XCTAssertFalse(sut.showAlert, "Alert should not be shown when last search succeeds")
        XCTAssertEqual(sut.characters.count, 3, "Only the last search result should be applied")
    }

    // MARK: - Helpers

    @MainActor
    private func makeSUT(
        getAllResult: Result<[CharacterEntity], CharacterDomainError> = .success([]),
        searchResult: Result<[CharacterEntity], CharacterDomainError> = .success([]),
        imageResult: Result<Data, CharacterImageError> = .success(Data())
    ) -> CharacterListViewModel {
        CharacterListViewModel(
            getAllCharactersUseCase: GetAllCharactersUseCaseStub(result: getAllResult),
            searchCharactersUseCase: SearchCharactersUseCaseStub(result: searchResult),
            downloadImageUseCase: DownloadCharacterImageUseCaseStub(result: imageResult),
            errorMapper: CharacterPresentableErrorMapper(),
            debounceInterval: 0
        )
    }

    @MainActor
    private func awaitPublishedChange(_ object: CharacterListViewModel, timeout: TimeInterval = 1.0) async {
        let expectation = XCTestExpectation(description: "Published value changed")
        let cancellable = object.objectWillChange.sink { _ in
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: timeout)
        cancellable.cancel()
    }
}
