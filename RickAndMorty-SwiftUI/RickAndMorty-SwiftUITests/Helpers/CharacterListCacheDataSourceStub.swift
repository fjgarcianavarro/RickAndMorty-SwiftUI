//
//  CharacterListCacheDataSourceStub.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 06.02.2025.
//

import Foundation
@testable import RickAndMorty_SwiftUI

actor CharacterListCacheDataSourceStub: CharacterListCacheDataSourceType {
    private let getCharacterList: [CharacterEntity]
    var cachedCharacterList: [CharacterEntity]?
    
    init(getCharacterList: [CharacterEntity]) {
        self.getCharacterList = getCharacterList
    }
    
    func getCharacterList() async -> [CharacterEntity] {
        getCharacterList
    }
    
    func saveCharacterList(_ characterList: [CharacterEntity]) async {
        cachedCharacterList = characterList
    }
}
