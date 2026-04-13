//
//  CharacterStorage.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 15.02.2025.
//

import Foundation
import SwiftData

actor CharacterStorage: CharacterStorageType, ModelActor {
    nonisolated let modelContainer: ModelContainer
    nonisolated let modelExecutor: any ModelExecutor
    private let mapper: CharacterDataStorageMapper

    init(modelContainer: ModelContainer, mapper: CharacterDataStorageMapper) {
        let context = ModelContext(modelContainer)
        self.modelExecutor = DefaultSerialModelExecutor(modelContext: context)
        self.modelContainer = modelContainer
        self.mapper = mapper
    }

    func fetchCharacter(id: Int, isDetailed: Bool) -> CharacterStorageDTO? {
        let descriptor = FetchDescriptor<CharacterData>(
            predicate: #Predicate { $0.id == id && $0.isDetailed == isDetailed }
        )

        guard let characterData = try? modelContext.fetch(descriptor).first else {
            return nil
        }

        return mapper.map(model: characterData)
    }

    func upsert(_ character: CharacterStorageDTO) {
        let characterId = character.id
        let descriptor = FetchDescriptor<CharacterData>(
            predicate: #Predicate { $0.id == characterId }
        )

        if let existing = try? modelContext.fetch(descriptor).first {
            existing.name = character.name
            existing.status = character.status
            existing.species = character.species
            existing.type = character.type
            existing.gender = character.gender
            existing.origin = LocationData(name: character.origin.name, url: character.origin.url)
            existing.location = LocationData(name: character.location.name, url: character.location.url)
            existing.imageURL = character.imageURL
            existing.episodes = character.episodes
            existing.isDetailed = character.isDetailed
        } else {
            modelContext.insert(mapper.map(dto: character))
        }

        try? modelContext.save()
    }
}
