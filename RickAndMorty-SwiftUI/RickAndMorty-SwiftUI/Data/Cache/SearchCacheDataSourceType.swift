//
//  SearchCacheDataSourceType.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 13.04.2026.
//

import Foundation

protocol SearchCacheDataSourceType: Sendable {
    func get(query: String) async -> [CharacterEntity]?
    func save(query: String, characters: [CharacterEntity]) async
}
