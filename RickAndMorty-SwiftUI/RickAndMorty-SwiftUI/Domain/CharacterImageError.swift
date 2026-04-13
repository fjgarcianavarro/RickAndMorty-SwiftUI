//
//  CharacterImageError.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 09.02.2025.
//

import Foundation

nonisolated enum CharacterImageError: Error {
    case invalidURL
    case networkError
    case unknown
}
