//
//  GetAllCharactersUseCaseTests.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José García Navarro on 06.02.2025.
//

import XCTest
@testable import RickAndMorty_SwiftUI

nonisolated final class GetAllCharactersUseCaseTests: XCTestCase {
    /// Ensures that `execute` returns a non-empty array when the repository provides valid data.
    @MainActor func test_execute_succeeds_when_repository_returns_nonEmpty_array() async throws {
        // GIVEN
        let mockCharacterList = CharacterEntityTestData.makeCharacterList()
        let repositoryStub = CharacterRepositoryStub(result: .success(mockCharacterList))
        let sut = GetAllCharactersUseCase(repository: repositoryStub)
        
        // WHEN
        let capturedResult = await sut.execute()
        
        // THEN
        let capturedCharacters = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCharacters, mockCharacterList, "Returned characters should match the repository data")
    }

    /// Ensures that `execute` returns an empty array when the repository provides an empty array.
    @MainActor func test_execute_succeeds_when_repository_returns_empty_array() async throws {
        // GIVEN
        let repositoryStub = CharacterRepositoryStub(result: .success([]))
        let sut = GetAllCharactersUseCase(repository: repositoryStub)

        // WHEN
        let capturedResult = await sut.execute()

        // THEN
        let capturedCharacters = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCharacters, [], "Returned characters should be empty when repository returns empty array")
    }

    /// Ensures that `execute` returns a generic error when the repository fails.
    @MainActor func test_execute_returns_error_when_repository_returns_failure() async {
        // GIVEN
        let repositoryStub = CharacterRepositoryStub(result: .failure(.generic))
        let sut = GetAllCharactersUseCase(repository: repositoryStub)

        // WHEN
        let capturedResult = await sut.execute()

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .generic, "Error should be .generic when repository fails with .generic")
    }

    /// Ensures that `execute` returns an `invalidResponse` error when the repository fails with an invalid response.
    @MainActor func test_execute_returns_invalidResponse_error_when_repository_fails_with_invalidResponse() async {
        // GIVEN
        let repositoryStub = CharacterRepositoryStub(result: .failure(.invalidResponse))
        let sut = GetAllCharactersUseCase(repository: repositoryStub)

        // WHEN
        let capturedResult = await sut.execute()

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .invalidResponse, "Error should be .invalidResponse when repository fails with .invalidResponse")
    }

    /// Ensures that `execute` returns a `tooManyRequests` error when the repository fails due to rate limiting.
    @MainActor func test_execute_returns_generic_error_when_repository_fails_with_unexpected_error() async {
        // GIVEN
        let repositoryStub = CharacterRepositoryStub(result: .failure(.tooManyRequests))
        let sut = GetAllCharactersUseCase(repository: repositoryStub)

        // WHEN
        let capturedResult = await sut.execute()

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .tooManyRequests, "Error should be .tooManyRequests when repository fails with .tooManyRequests")
    }

    /// Ensures that `execute` returns a `decodingFailed` error when the repository fails due to decoding issues.
    @MainActor func test_execute_returns_decodingFailed_when_repository_fails_with_decodingError() async {
        // GIVEN
        let repositoryStub = CharacterRepositoryStub(result: .failure(.decodingFailed))
        let sut = GetAllCharactersUseCase(repository: repositoryStub)

        // WHEN
        let capturedResult = await sut.execute()

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .decodingFailed, "Error should be .decodingFailed when repository fails with .decodingFailed")
    }
}
