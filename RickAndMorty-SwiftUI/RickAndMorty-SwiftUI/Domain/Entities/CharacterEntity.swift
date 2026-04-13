//
//  CharacterEntity.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 01.02.2025.
//

import Foundation

nonisolated struct CharacterEntity: Sendable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String?
    let gender: CharacterGender
    let origin: LocationEntity
    let location: LocationEntity
    let imageURL: URL?
    let episodes: [String]
}

// Enum para Status
nonisolated enum CharacterStatus: String, Sendable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

// Enum para Gender
nonisolated enum CharacterGender: String, Sendable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
}
