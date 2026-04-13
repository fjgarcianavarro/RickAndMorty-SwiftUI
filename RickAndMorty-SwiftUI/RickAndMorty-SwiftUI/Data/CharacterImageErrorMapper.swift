//
//  CharacterImageErrorMapper.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 09.02.2025.
//

import Foundation

nonisolated struct CharacterImageErrorMapper {
    func map(error: HTTPClientError?) -> CharacterImageError {
        guard error == .clientError || error == .invalidURL else {
            return .unknown
        }
        
        return .invalidURL
    }
}
