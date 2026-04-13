//
//  CharacterStorageDTOMapper.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 12.04.2026.
//

import Foundation

nonisolated struct CharacterStorageDTOMapper {
    func map(dto: CharacterStorageDTO) -> CharacterEntity {
        CharacterEntity(
            id: dto.id,
            name: dto.name,
            status: CharacterStatus(rawValue: dto.status) ?? .unknown,
            species: dto.species,
            type: dto.type,
            gender: CharacterGender(rawValue: dto.gender) ?? .unknown,
            origin: LocationEntity(
                name: dto.origin.name,
                url: dto.origin.url.flatMap { URL(string: $0) }
            ),
            location: LocationEntity(
                name: dto.location.name,
                url: dto.location.url.flatMap { URL(string: $0) }
            ),
            imageURL: dto.imageURL.flatMap { URL(string: $0) },
            episodes: dto.episodes ?? []
        )
    }

    func map(entity: CharacterEntity, isDetailed: Bool = false) -> CharacterStorageDTO {
        CharacterStorageDTO(
            id: entity.id,
            name: entity.name,
            status: entity.status.rawValue,
            species: entity.species,
            type: entity.type,
            gender: entity.gender.rawValue,
            origin: LocationStorageDTO(
                name: entity.origin.name,
                url: entity.origin.url?.absoluteString
            ),
            location: LocationStorageDTO(
                name: entity.location.name,
                url: entity.location.url?.absoluteString
            ),
            imageURL: entity.imageURL?.absoluteString,
            episodes: entity.episodes,
            isDetailed: isDetailed
        )
    }
}
