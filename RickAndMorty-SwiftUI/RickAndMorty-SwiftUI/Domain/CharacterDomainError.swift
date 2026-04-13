//
//  CharacterDomainError.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 01.02.2025.
//

import Foundation

nonisolated enum CharacterDomainError: Error {
    case generic
    case invalidResponse
    case decodingFailed
    case tooManyRequests
}
