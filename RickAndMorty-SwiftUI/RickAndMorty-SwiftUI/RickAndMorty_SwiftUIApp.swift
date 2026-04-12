//
//  RickAndMorty_SwiftUIApp.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 31.01.2025.
//

import SwiftUI

@main
struct RickAndMorty_SwiftUIApp: App {
    private let container = DependencyContainer()

    var body: some Scene {
        WindowGroup {
            ContentView(characterListView: CharacterListFactory.create(container: container))
        }
    }
}
