//
//  ContentView.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 31.01.2025.
//

import SwiftUI

struct ContentView: View {
    let characterListView: CharacterListView
    
    var body: some View {
        characterListView
    }
}

#Preview {
    ContentView(characterListView: CharacterListView(viewModel: .preview,
                                                     createCharacterDetailView: CharacterDetailFactory(container: DependencyContainer())))
}
