//
//  CharacterImageRemoteDataSource.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 09.02.2025.
//

import Foundation

final class CharacterImageRemoteDataSource {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}

extension CharacterImageRemoteDataSource: CharacterImageRemoteDataSourceType {
    func downloadImage(from url: URL) async -> Result<Data, HTTPClientError> {
        let result = await httpClient.download(from: url)
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }

        return .success(data)
    }
}

private extension CharacterImageRemoteDataSource {
    func handleError(error: HTTPClientError?) -> HTTPClientError {
        error ?? .unknownError
    }
}
