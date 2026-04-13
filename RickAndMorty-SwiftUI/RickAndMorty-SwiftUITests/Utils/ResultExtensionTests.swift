//
//  ResultExtensionTests.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José García Navarro on 08.02.2025.
//

import XCTest
@testable import RickAndMorty_SwiftUI

nonisolated final class ResultExtensionTests: XCTestCase {
    /// Ensures that `failureValue` correctly returns the error when the `Result` is a failure.
    func test_failureValue_returns_error_when_result_is_failure() {
        // GIVEN
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        let result: Result<Int, Error> = .failure(expectedError)
        
        // WHEN
        let capturedError = result.failureValue
        
        // THEN
        XCTAssertNotNil(capturedError)
        XCTAssertEqual(capturedError?.localizedDescription, expectedError.localizedDescription)
    }
    
    /// Ensures that `failureValue` returns `nil` when the `Result` is a success.
    func test_failureValue_returns_nil_when_result_is_success() {
        // GIVEN
        let result: Result<Int, Error> = .success(42)
        
        // WHEN
        let capturedError = result.failureValue
        
        // THEN
        XCTAssertNil(capturedError)
    }
}
