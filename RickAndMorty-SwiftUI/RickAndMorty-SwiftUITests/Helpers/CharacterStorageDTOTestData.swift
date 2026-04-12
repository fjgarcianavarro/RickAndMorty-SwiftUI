//
//  CharacterStorageDTOTestData.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 12.04.2026.
//

import Foundation
@testable import RickAndMorty_SwiftUI

struct CharacterStorageDTOTestData {
    static func makeCharacterList() -> [CharacterStorageDTO] {
        return [
            CharacterStorageDTO(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: makeLocation(),
                location: makeLocation(),
                imageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                ],
                isDetailed: false
            ),
            CharacterStorageDTO(
                id: 2,
                name: "Morty Smith",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: makeLocation(),
                location: makeLocation(),
                imageURL: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                ],
                isDetailed: false
            ),
            CharacterStorageDTO(
                id: 3,
                name: "Summer Smith",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Female",
                origin: makeLocation(),
                location: makeLocation(),
                imageURL: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/6",
                    "https://rickandmortyapi.com/api/episode/7",
                    "https://rickandmortyapi.com/api/episode/8",
                    "https://rickandmortyapi.com/api/episode/9",
                ],
                isDetailed: false
            )
        ]
    }

    static func makeLocation() -> LocationStorageDTO {
        LocationStorageDTO(
            name: "Earth (C-137)",
            url: "https://rickandmortyapi.com/api/location/1"
        )
    }
}
