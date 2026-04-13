//
//  CharacterCacheDataSourceType.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 15.02.2025.
//

import Foundation

protocol CharacterCacheDataSourceType: Sendable {
    func getCharacter(id: Int) async -> CharacterEntity?
    func saveCharacter(character: CharacterEntity) async
}
