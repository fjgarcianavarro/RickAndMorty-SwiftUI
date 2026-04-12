//
//  CharacterDataStorageMapper.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 12.04.2026.
//

import Foundation

nonisolated struct CharacterDataStorageMapper {
    func map(model: CharacterData) -> CharacterStorageDTO {
        CharacterStorageDTO(
            id: model.id,
            name: model.name,
            status: model.status,
            species: model.species,
            type: model.type,
            gender: model.gender,
            origin: LocationStorageDTO(name: model.origin.name, url: model.origin.url),
            location: LocationStorageDTO(name: model.location.name, url: model.location.url),
            imageURL: model.imageURL,
            episodes: model.episodes,
            isDetailed: model.isDetailed
        )
    }

    func map(dto: CharacterStorageDTO) -> CharacterData {
        CharacterData(
            id: dto.id,
            name: dto.name,
            status: dto.status,
            species: dto.species,
            type: dto.type,
            gender: dto.gender,
            origin: LocationData(name: dto.origin.name, url: dto.origin.url),
            location: LocationData(name: dto.location.name, url: dto.location.url),
            imageURL: dto.imageURL,
            episodes: dto.episodes,
            isDetailed: dto.isDetailed
        )
    }
}
