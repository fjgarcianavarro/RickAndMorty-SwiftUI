//
//  SearchCacheDataSourceStub.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José García Navarro on 13.04.2026.
//

import Foundation
@testable import RickAndMorty_SwiftUI

actor SearchCacheDataSourceStub: SearchCacheDataSourceType {
    private var cachedResult: [CharacterEntity]?
    var savedQuery: String?
    var savedCharacters: [CharacterEntity]?

    init(cachedResult: [CharacterEntity]? = nil) {
        self.cachedResult = cachedResult
    }

    func get(query: String) async -> [CharacterEntity]? {
        cachedResult
    }

    func save(query: String, characters: [CharacterEntity]) async {
        savedQuery = query
        savedCharacters = characters
    }
}
