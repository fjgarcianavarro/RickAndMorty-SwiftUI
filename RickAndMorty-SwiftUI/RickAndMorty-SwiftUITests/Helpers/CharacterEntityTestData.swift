//
//  CharacterEntityTestData.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 06.02.2025.
//

import Foundation
@testable import RickAndMorty_SwiftUI

struct CharacterEntityTestData {
    static func makeCharacterList() -> [CharacterEntity] {
        return [
            CharacterEntity(
                id: 1,
                name: "Rick Sanchez",
                status: .alive,
                species: "Human",
                type: nil,
                gender: .male,
                origin: makeLocation(),
                location: makeLocation(),
                imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                episodes: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                ]
            ),
            CharacterEntity(
                id: 2,
                name: "Morty Smith",
                status: .alive,
                species: "Human",
                type: nil,
                gender: .male,
                origin: makeLocation(),
                location: makeLocation(),
                imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"),
                episodes: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                ]
            ),
            CharacterEntity(
                id: 3,
                name: "Summer Smith",
                status: .alive,
                species: "Human",
                type: nil,
                gender: .female,
                origin: makeLocation(),
                location: makeLocation(),
                imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg"),
                episodes: [
                    "https://rickandmortyapi.com/api/episode/6",
                    "https://rickandmortyapi.com/api/episode/7",
                    "https://rickandmortyapi.com/api/episode/8",
                    "https://rickandmortyapi.com/api/episode/9",
                ]
            )
        ]
    }
    
    static func makeOtherCharacterList() -> [CharacterEntity] {
        return makeCharacterList().reversed()
    }
    
    static func makeLocation() -> LocationEntity {
        return LocationEntity(name: "Earth (C-137)",
                              url: URL(string: "https://rickandmortyapi.com/api/location/1"))
    }
}
