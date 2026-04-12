//
//  CharacterDomainError.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 01.02.2025.
//

import Foundation

nonisolated enum CharacterDomainError: Error {
    case generic
    case invalidResponse
    case decodingFailed
    case tooManyRequests
}
