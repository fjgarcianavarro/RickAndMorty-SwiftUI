//
//  CharacterListStorageStub.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 08.02.2025.
//

import Foundation
@testable import RickAndMorty_SwiftUI

actor CharacterListStorageStub: CharacterListStorageType {
    private(set) var insertedCharacters: [CharacterStorageDTO] = []
    private let fetchCharactersResult: [CharacterStorageDTO]

    init(fetchCharactersResult: [CharacterStorageDTO]) {
        self.fetchCharactersResult = fetchCharactersResult
    }

    func fetchCharacters() async -> [CharacterStorageDTO] {
        fetchCharactersResult
    }

    func insert(_ characters: [CharacterStorageDTO]) async {
        insertedCharacters = characters
    }
}
