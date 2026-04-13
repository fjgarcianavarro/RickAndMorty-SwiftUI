//
//  CharacterDomainErrorMapper.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 04.02.2025.
//

import Foundation

nonisolated struct CharacterDomainErrorMapper {
    func map(error: HTTPClientError?) -> CharacterDomainError {
        switch error {
        case .clientError, .responseError:
            return .invalidResponse
        case .decodingError:
            return .decodingFailed
        case .tooManyRequests:
            return .tooManyRequests
        case .serverError, .invalidURL, .unknownError, .none:
            return .generic
        }
    }
}
