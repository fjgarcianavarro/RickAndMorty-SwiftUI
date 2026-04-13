//
//  CharacterListRemoteDataSourceStub.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José Navarro García on 06.02.2025.
//

import Foundation
@testable import RickAndMorty_SwiftUI

final class CharacterListRemoteDataSourceStub: CharacterListRemoteDataSourceType {
    private let getCharacters: Result<[CharacterDTO], HTTPClientError>
    
    init(getCharacters: Result<[CharacterDTO], HTTPClientError>) {
        self.getCharacters = getCharacters
    }
    
    func getCharacters() async -> Result<[CharacterDTO], HTTPClientError> {
        getCharacters
    }

    func searchCharacters(name: String) async -> Result<[CharacterDTO], HTTPClientError> {
        getCharacters
    }
}
