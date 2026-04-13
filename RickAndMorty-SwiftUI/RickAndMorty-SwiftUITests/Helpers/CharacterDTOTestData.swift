//
//  CharacterDTOTestData.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 06.02.2025.
//

import Foundation
@testable import RickAndMorty_SwiftUI

struct CharacterDTOTestData {
    static func makeCharacterList() -> [CharacterDTO] {
        return [
            CharacterDTO(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: makeLocation(),
                location: makeLocation(),
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episode: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                ],
                url: nil
            ),
            CharacterDTO(
                id: 2,
                name: "Morty Smith",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: makeLocation(),
                location: makeLocation(),
                image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                episode: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                ],
                url: nil
            ),
            CharacterDTO(
                id: 3,
                name: "Summer Smith",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Female",
                origin: makeLocation(),
                location: makeLocation(),
                image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
                episode: [
                    "https://rickandmortyapi.com/api/episode/6",
                    "https://rickandmortyapi.com/api/episode/7",
                    "https://rickandmortyapi.com/api/episode/8",
                    "https://rickandmortyapi.com/api/episode/9",
                ],
                url: nil
            )
        ]
    }
    
    static func makeLocation() -> LocationDTO {
        return LocationDTO(name: "Earth (C-137)",
                           url: "https://rickandmortyapi.com/api/location/1")
    }
}
