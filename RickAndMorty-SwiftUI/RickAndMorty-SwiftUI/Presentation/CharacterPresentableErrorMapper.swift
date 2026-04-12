//
//  CharacterPresentableErrorMapper.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 03.02.2025.
//

import Foundation

struct CharacterPresentableErrorMapper {
    func map(error: CharacterDomainError?) -> LocalizedStringResource {
        switch error {
        case .generic:
            return LocalizedErrorKey.generic.localized
        case .invalidResponse:
            return LocalizedErrorKey.invalidResponse.localized
        case .decodingFailed:
            return LocalizedErrorKey.decodingFailed.localized
        case .tooManyRequests:
            return LocalizedErrorKey.tooManyRequests.localized
        case .none:
            return LocalizedErrorKey.unknown.localized
        }
    }
}
