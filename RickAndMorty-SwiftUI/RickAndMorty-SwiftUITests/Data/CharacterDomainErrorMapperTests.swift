//
//  CharacterDomainErrorMapperTests.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José García Navarro on 08.02.2025.
//

import XCTest
@testable import RickAndMorty_SwiftUI

nonisolated final class CharacterDomainErrorMapperTests: XCTestCase {
    /// Ensures that `map(error:)` correctly maps `.tooManyRequests` from `HTTPClientError` to `CharacterDomainError.tooManyRequests`.
    func test_map_returns_tooManyRequests_when_error_is_tooManyRequests() {
        // GIVEN
        let sut = CharacterDomainErrorMapper()
        
        // WHEN
        let mappedError = sut.map(error: .tooManyRequests)
        
        // THEN
        XCTAssertEqual(mappedError, .tooManyRequests)
    }
    
    /// Ensures that `map(error:)` correctly maps `.clientError` and `.responseError` to `CharacterDomainError.invalidResponse`.
    func test_map_returns_invalidResponse_when_error_is_clientError_or_responseError() {
        // GIVEN
        let sut = CharacterDomainErrorMapper()
        let errorsToTest: [HTTPClientError] = [.clientError, .responseError]
        
        // WHEN & THEN
        for error in errorsToTest {
            XCTAssertEqual(sut.map(error: error), .invalidResponse, "Failed for error: \(error)")
        }
    }
    
    /// Ensures that `map(error:)` correctly maps `.decodingError` to `CharacterDomainError.decodingFailed`.
    func test_map_returns_decodingFailed_when_error_is_decodingError() {
        // GIVEN
        let sut = CharacterDomainErrorMapper()
        
        // WHEN
        let mappedError = sut.map(error: .decodingError)
        
        // THEN
        XCTAssertEqual(mappedError, .decodingFailed)
    }
    
    /// Ensures that `map(error:)` correctly maps `.serverError`, `.invalidURL`, and `.unknownError` to `CharacterDomainError.generic`.
    func test_map_returns_generic_when_error_is_serverError_invalidURL_or_unknownError() {
        // GIVEN
        let sut = CharacterDomainErrorMapper()
        let errorsToTest: [HTTPClientError] = [.serverError, .invalidURL, .unknownError]
        
        // WHEN & THEN
        for error in errorsToTest {
            XCTAssertEqual(sut.map(error: error), .generic, "Failed for error: \(error)")
        }
    }
    
    /// Ensures that `map(error:)` returns `.generic` when the provided error is `nil`.
    func test_map_returns_generic_when_error_is_nil() {
        // GIVEN
        let sut = CharacterDomainErrorMapper()
        
        // WHEN
        let mappedError = sut.map(error: nil)
        
        // THEN
        XCTAssertEqual(mappedError, .generic)
    }
}
