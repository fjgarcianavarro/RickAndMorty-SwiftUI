//
//  CharacterPresentable.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 01.02.2025.
//

import Foundation

nonisolated struct CharacterPresentable: Sendable {
    let id: String
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: String
    let location: String
    let imageURL: String?
    
    init(domainModel: CharacterEntity) {
        self.id = "\(domainModel.id)"
        self.name = domainModel.name
        self.status = domainModel.status.rawValue
        self.type = domainModel.type
        self.species = domainModel.species
        self.gender = domainModel.gender.rawValue
        self.origin = domainModel.origin.name
        self.location = domainModel.location.name
        self.imageURL = domainModel.imageURL?.absoluteString
    }
}

extension CharacterPresentable: Identifiable {
    
}

extension CharacterPresentable: Hashable {
    
}
