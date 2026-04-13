//
//  CharacterImageRepositoryType.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 09.02.2025.
//

import Foundation

protocol CharacterImageRepositoryType: Sendable {
    func getImage(for url: URL) async -> Result<Data, CharacterImageError>
}
