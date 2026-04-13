//
//  CharacterDomainMapperTests.swift
//  RickAndMorty-SwiftUITests
//
//  Created by Francisco José García Navarro on 08.02.2025.
//

import XCTest
@testable import RickAndMorty_SwiftUI

nonisolated final class CharacterDomainMapperTests: XCTestCase {
    /// Ensures that `map(character:)` correctly maps a valid `CharacterDTO` to `CharacterEntity`.
    func test_mapCharacter_correctly_maps_valid_characterDTO() {
        // GIVEN
        let dto = CharacterDTO(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: nil,
            gender: "Male",
            origin: LocationDTO(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
            location: LocationDTO(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: ["https://rickandmortyapi.com/api/episode/1"],
            url: nil
        )
        
        let expectedEntity = CharacterEntity(
            id: 1,
            name: "Rick Sanchez",
            status: .alive,
            species: "Human",
            type: nil,
            gender: .male,
            origin: LocationEntity(name: "Earth (C-137)", url: URL(string: "https://rickandmortyapi.com/api/location/1")),
            location: LocationEntity(name: "Citadel of Ricks", url: URL(string: "https://rickandmortyapi.com/api/location/3")),
            imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
            episodes: ["https://rickandmortyapi.com/api/episode/1"]
        )
        
        let sut = CharacterDomainMapper()
        
        // WHEN
        let mappedEntity = sut.map(character: dto)
        
        // THEN
        XCTAssertEqual(mappedEntity, expectedEntity, "Valid DTO should be correctly mapped to entity with all fields")
    }

    /// Ensures that `map(character:)` correctly handles `nil` values by assigning default values.
    func test_mapCharacter_handles_nil_values_gracefully() {
        // GIVEN
        let dto = CharacterDTO(
            id: 2,
            name: "Morty Smith",
            status: nil,
            species: nil,
            type: nil,
            gender: nil,
            origin: nil,
            location: nil,
            image: nil,
            episode: nil,
            url: nil
        )
        
        let expectedEntity = CharacterEntity(
            id: 2,
            name: "Morty Smith",
            status: .unknown,  // Default value
            species: "",       // Default value
            type: nil,
            gender: .unknown,  // Default value
            origin: LocationEntity(name: "Unknown", url: nil),
            location: LocationEntity(name: "Unknown", url: nil),
            imageURL: nil,
            episodes: []
        )
        
        let sut = CharacterDomainMapper()
        
        // WHEN
        let mappedEntity = sut.map(character: dto)
        
        // THEN
        XCTAssertEqual(mappedEntity, expectedEntity, "DTO with nil values should be mapped to entity with default values")
    }

    /// Ensures that `map(characterList:)` correctly maps a list of `CharacterDTO` objects into `CharacterEntity` objects.
    func test_mapCharacterList_correctly_maps_valid_characterDTOs() {
        // GIVEN
        let dtos = [
            CharacterDTO(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: LocationDTO(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                location: LocationDTO(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episode: ["https://rickandmortyapi.com/api/episode/1"],
                url: nil
            ),
            CharacterDTO(
                id: 2,
                name: "Morty Smith",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: LocationDTO(name: "Unknown", url: nil),
                location: LocationDTO(name: "Unknown", url: nil),
                image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                episode: ["https://rickandmortyapi.com/api/episode/2"],
                url: nil
            )
        ]
        
        let expectedEntities = [
            CharacterEntity(
                id: 1,
                name: "Rick Sanchez",
                status: .alive,
                species: "Human",
                type: nil,
                gender: .male,
                origin: LocationEntity(name: "Earth (C-137)", url: URL(string: "https://rickandmortyapi.com/api/location/1")),
                location: LocationEntity(name: "Citadel of Ricks", url: URL(string: "https://rickandmortyapi.com/api/location/3")),
                imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                episodes: ["https://rickandmortyapi.com/api/episode/1"]
            ),
            CharacterEntity(
                id: 2,
                name: "Morty Smith",
                status: .alive,
                species: "Human",
                type: nil,
                gender: .male,
                origin: LocationEntity(name: "Unknown", url: nil),
                location: LocationEntity(name: "Unknown", url: nil),
                imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"),
                episodes: ["https://rickandmortyapi.com/api/episode/2"]
            )
        ]
        
        let sut = CharacterDomainMapper()
        
        // WHEN
        let mappedEntities = sut.map(characterList: dtos)
        
        // THEN
        XCTAssertEqual(mappedEntities, expectedEntities, "List of DTOs should be correctly mapped to list of entities")
    }
}
