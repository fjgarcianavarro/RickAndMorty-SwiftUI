//
//  CharacterDTO.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 01.02.2025.
//

import Foundation

nonisolated struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: LocationDTO?
    let location: LocationDTO?
    let image: String?
    let episode: [String]?
    let url: String?
}
