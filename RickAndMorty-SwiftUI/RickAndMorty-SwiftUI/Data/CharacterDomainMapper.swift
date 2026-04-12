//
//  CharacterDomainMapper.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 02.02.2025.
//

import Foundation

nonisolated struct CharacterDomainMapper {
    func map(character: CharacterDTO) -> CharacterEntity {
        return CharacterEntity(
            id: character.id,
            name: character.name,
            status: CharacterStatus(rawValue: character.status ?? "unknown") ?? .unknown,
            species: character.species ?? "",
            type: character.type,
            gender: CharacterGender(rawValue: character.gender ?? "unknown") ?? .unknown,
            origin: map(location: character.origin),
            location: map(location: character.location),
            imageURL: URL(string: character.image ?? ""),
            episodes: character.episode ?? []
        )
    }
    
    func map(characterList: [CharacterDTO]) -> [CharacterEntity] {
        return characterList.map { map(character: $0) }
    }
    
    private func map(location: LocationDTO?) -> LocationEntity {
        return LocationEntity(
            name: location?.name ?? "Unknown",
            url: URL(string: location?.url ?? "")
        )
    }
}
