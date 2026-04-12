//
//  CharacterData.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 04.02.2025.
//

import Foundation
import SwiftData

@Model
nonisolated class CharacterData {
    @Attribute(.unique) var id: Int
    var name: String
    var status: String
    var species: String
    var type: String?
    var gender: String
    var origin: LocationData
    var location: LocationData
    var imageURL: String?
    var episodes: [String]?
    var isDetailed: Bool
    
    init(id: Int, name: String, status: String, species: String, type: String?, gender: String, origin: LocationData, location: LocationData, imageURL: String?, episodes: [String]?, isDetailed: Bool = false) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.imageURL = imageURL
        self.episodes = episodes
        self.isDetailed = isDetailed
    }
}
