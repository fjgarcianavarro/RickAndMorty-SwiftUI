//
//  CharacterStorageDTO.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 12.04.2026.
//

import Foundation

nonisolated struct CharacterStorageDTO: Sendable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: LocationStorageDTO
    let location: LocationStorageDTO
    let imageURL: String?
    let episodes: [String]?
    let isDetailed: Bool
}

nonisolated struct LocationStorageDTO: Sendable {
    let name: String
    let url: String?
}
