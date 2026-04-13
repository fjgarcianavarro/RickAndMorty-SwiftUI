//
//  SearchCharactersUseCaseTests.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José Navarro García on 13.04.2026.
//

import XCTest
@testable import RickAndMorty_SwiftUI

nonisolated final class SearchCharactersUseCaseTests: XCTestCase {

    @MainActor func test_execute_returnsCharacters_onSuccess() async throws {
        // GIVEN
        let expectedCharacters = CharacterEntityTestData.makeCharacterList()
        let repositoryStub = CharacterRepositoryStub(result: .success(expectedCharacters))
        let sut = SearchCharactersUseCase(repository: repositoryStub)

        // WHEN
        let result = await sut.execute(name: "rick")

        // THEN
        let capturedCharacters = try XCTUnwrap(result.get())
        XCTAssertEqual(capturedCharacters, expectedCharacters)
    }

    @MainActor func test_execute_returnsError_onFailure() async {
        // GIVEN
        let repositoryStub = CharacterRepositoryStub(result: .failure(.generic))
        let sut = SearchCharactersUseCase(repository: repositoryStub)

        // WHEN
        let result = await sut.execute(name: "rick")

        // THEN
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        XCTAssertEqual(error, .generic)
    }
}
