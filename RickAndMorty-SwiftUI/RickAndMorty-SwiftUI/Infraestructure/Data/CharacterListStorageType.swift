//
//  CharacterListStorageType.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 04.02.2025.
//

import Foundation

protocol CharacterListStorageType: Sendable {
    func fetchCharacters() async -> [CharacterStorageDTO]
    func insert(_ characters: [CharacterStorageDTO]) async
}
