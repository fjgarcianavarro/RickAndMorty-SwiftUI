//
//  RemoteDataSourceTests.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José García Navarro on 06.02.2025.
//

import XCTest
@testable import RickAndMorty_SwiftUI

nonisolated final class RemoteDataSourceTests: XCTestCase {
    /// Ensures that `getCharacters` succeeds when the HTTP client returns a valid response with character data.
    @MainActor func test_getCharacters_succeeds_when_httpclient_requests_succeeds_and_response_is_correct() async throws {
        // GIVEN
        let data = """
                {
                    "results": [
                        {
                            "id": 1,
                            "name": "Rick Sanchez",
                            "status": "Alive",
                            "species": "Human",
                            "gender": "Male",
                            "origin": {
                                "name": "Earth (C-137)",
                                "url": "https://rickandmortyapi.com/api/location/1"
                            },
                            "location": {
                                "name": "Citadel of Ricks",
                                "url": "https://rickandmortyapi.com/api/location/3"
                            },
                            "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                            "episode": [
                                "https://rickandmortyapi.com/api/episode/1",
                                "https://rickandmortyapi.com/api/episode/2"
                            ]
                        }
                    ]
                }
                """.data(using: .utf8)
        
        let expectedResult = [
            CharacterDTO(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: LocationDTO(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                location: LocationDTO(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episode: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2"
                ],
                url: nil
            )
        ]
        let sut = RemoteDataSource(httpClient: HTTPClientStub(result: .success(data!)))
        
        // WHEN
        let capturedResult = await sut.getCharacters()
        
        // THEN
        let result = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(result, expectedResult)
    }
    
    /// Ensures that `getCharacters` fails when the HTTP client request fails.
    @MainActor func test_getCharacters_fails_when_httpClient_request_fails() async {
        // GIVEN
        let sut = RemoteDataSource(httpClient: HTTPClientStub(result: .failure(.unknownError)))
        
        // WHEN
        let capturedResult = await sut.getCharacters()
        
        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, .unknownError)
    }
    
    /// Ensures that `getCharacters` returns an empty array when the response has no results.
    @MainActor func test_getCharacters_returns_emptyArray_when_httpclient_requests_succeeds_and_response_has_no_results() async throws {
        // GIVEN
        let jsonData = """
            {
                "results": null
            }
            """.data(using: .utf8)
        
        let sut = RemoteDataSource(httpClient: HTTPClientStub(result: .success(jsonData!)))
        
        // WHEN
        let capturedResult = await sut.getCharacters()
        
        // THEN
        let result = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(result, [])
    }
    
    /// Ensures that `getCharacters` returns an empty array when the API returns an empty object.
    @MainActor func test_getCharacters_returns_emptyArray_when_response_is_empty() async throws {
        // GIVEN
        let emptyData = """
            {}
            """.data(using: .utf8)

        let sut = RemoteDataSource(httpClient: HTTPClientStub(result: .success(emptyData!)))

        // WHEN
        let capturedResult = await sut.getCharacters()

        // THEN
        let result = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(result, [])
    }
    
    /// Ensures that `getCharacters` handles missing fields gracefully and provides default values.
    @MainActor func test_getCharacters_handles_missing_fields_gracefully() async throws {
        // GIVEN
        let dataWithMissingFields = """
            {
                "results": [
                    {
                        "id": 1,
                        "name": "Rick Sanchez"
                    }
                ]
            }
            """.data(using: .utf8)

        let expectedResult = [
            CharacterDTO(
                id: 1,
                name: "Rick Sanchez",
                status: nil,
                species: nil,
                type: nil,
                gender: nil,
                origin: nil,
                location: nil,
                image: nil,
                episode: nil,
                url: nil
            )
        ]

        let sut = RemoteDataSource(httpClient: HTTPClientStub(result: .success(dataWithMissingFields!)))

        // WHEN
        let capturedResult = await sut.getCharacters()

        // THEN
        let result = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(result, expectedResult)
    }
    
    /// Ensures that `getCharacters` returns `.tooManyRequests` when the API rate limit is exceeded.
    @MainActor func test_getCharacters_fails_with_tooManyRequests_when_httpClient_returns_429() async {
        // GIVEN
        let sut = RemoteDataSource(httpClient: HTTPClientStub(result: .failure(.tooManyRequests)))

        // WHEN
        let capturedResult = await sut.getCharacters()

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, .tooManyRequests)
    }
}
