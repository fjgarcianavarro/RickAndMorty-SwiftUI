//
//  CharacterDetailRemoteDataSource.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 12.02.2025.
//

import Foundation

final class CharacterDetailRemoteDataSource {
    private let httpClient: HTTPClient
    private let baseURL: String
    
    init(httpClient: HTTPClient, baseURL: String = APIConstants.baseURL) {
        self.httpClient = httpClient
        self.baseURL = baseURL
    }
}

extension CharacterDetailRemoteDataSource: CharacterDetailRemoteDataSourceType {
    func getCharacter(id: Int) async -> Result<CharacterDTO, HTTPClientError> {
        let endpoint = Endpoint(path: "character/\(id)",
                                queryParameters: [:],
                                method: .get)
        
        
        let result = await httpClient.makeRequest(endpoint: endpoint,
                                                  baseUrl: baseURL)
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        guard let character = try? JSONDecoder().decode(CharacterDTO.self, from: data) else {
            return .failure(.decodingError)
        }
        
        return .success(character)
    }
}

private extension CharacterDetailRemoteDataSource {
    func handleError(error: HTTPClientError?) -> HTTPClientError {
        error ?? .unknownError
    }
}
