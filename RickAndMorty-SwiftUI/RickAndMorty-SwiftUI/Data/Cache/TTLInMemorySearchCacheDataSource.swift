//
//  TTLInMemorySearchCacheDataSource.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 13.04.2026.
//

import Foundation

actor TTLInMemorySearchCacheDataSource: SearchCacheDataSourceType {
    private struct Entry {
        let characters: [CharacterEntity]
        let expiresAt: Date
    }

    private var store: [String: Entry] = [:]
    private let ttl: TimeInterval

    init(ttl: TimeInterval = 120) {
        self.ttl = ttl
    }

    func get(query: String) -> [CharacterEntity]? {
        guard let entry = store[normalizedKey(query)],
              entry.expiresAt > Date() else { return nil }
        return entry.characters
    }

    func save(query: String, characters: [CharacterEntity]) {
        store[normalizedKey(query)] = Entry(
            characters: characters,
            expiresAt: Date().addingTimeInterval(ttl)
        )
    }

    private func normalizedKey(_ query: String) -> String {
        query.lowercased().trimmingCharacters(in: .whitespaces)
    }
}
