//
//  CharacterListStorage.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 05.02.2025.
//

import Foundation
import SwiftData

nonisolated enum SharedModelContainer {
    static let instance: ModelContainer = {
        do {
            return try ModelContainer(for: CharacterData.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()
}

actor CharacterListStorage: CharacterListStorageType, ModelActor {
    nonisolated let modelContainer: ModelContainer
    nonisolated let modelExecutor: any ModelExecutor
    private let mapper: CharacterDataStorageMapper

    init(modelContainer: ModelContainer, mapper: CharacterDataStorageMapper) {
        let context = ModelContext(modelContainer)
        self.modelExecutor = DefaultSerialModelExecutor(modelContext: context)
        self.modelContainer = modelContainer
        self.mapper = mapper
    }

    func fetchCharacters() -> [CharacterStorageDTO] {
        let descriptor = FetchDescriptor<CharacterData>()
        let characters = (try? modelContext.fetch(descriptor)) ?? []
        return characters.map { mapper.map(model: $0) }
    }

    func insert(_ characters: [CharacterStorageDTO]) {
        let models = characters.map { mapper.map(dto: $0) }
        models.forEach { modelContext.insert($0) }
        try? modelContext.save()
    }
}
