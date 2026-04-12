//
//  CharacterStorageType.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 15.02.2025.
//

import Foundation

protocol CharacterStorageType: Sendable {
    func fetchCharacter(id: Int, isDetailed: Bool) async -> CharacterStorageDTO?
    func upsert(_ character: CharacterStorageDTO) async
}
