//
//  CharacterDetailViewFactory.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 13.02.2025.
//

import SwiftUI

protocol CharacterDetailViewFactory {
    func create(character: CharacterPresentable) -> CharacterDetailView
}
