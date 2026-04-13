//
//  CharacterListView.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 01.02.2025.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject private var viewModel: CharacterListViewModel
    
    private let createCharacterDetailView: CharacterDetailViewFactory
    
    let gridItem = GridItem(.adaptive(minimum: 150), alignment: .center)
    
    @State var typeList: CharacterListDisplayMode = .list
    
    init(viewModel: CharacterListViewModel, createCharacterDetailView: CharacterDetailViewFactory) {
        self.viewModel = viewModel
        self.createCharacterDetailView = createCharacterDetailView
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.loading {
                    CharacterListLoadingView()
                } else if viewModel.characters.isEmpty {
                    ContentUnavailableView(
                        "No characters found",
                        systemImage: "person.slash",
                        description: Text("Try a different search term")
                    )
                } else {
                    if typeList == .list {
                        List(viewModel.characters) { character in
                            NavigationLink(destination: createCharacterDetailView.create(character: character)) {
                                CharacterListItemView(character: character,
                                                      downloadImageUseCase: viewModel.downloadImageUseCase)
                            }
                        }
                    } else {
                        ScrollView {
                            LazyVGrid(columns: [gridItem]) {
                                ForEach(viewModel.characters) { character in
                                    NavigationLink(destination: createCharacterDetailView.create(character: character)) {
                                        CharacterGridItemView(character: character,
                                                              downloadImageUseCase: viewModel.downloadImageUseCase)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle(Text("Rick and Morty", comment: "Navigation bar title for the character list screen."))
            .searchable(text: $viewModel.searchText, prompt: "Search characters")
            .onChange(of: viewModel.searchText) { _, newValue in
                viewModel.onSearchTextChanged(newValue)
            }
            .toolbar {
                CharacterListTypeSwitcherView(typeList: $typeList)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .refreshable {
            viewModel.refreshData()
        }
        .customAlert(message: viewModel.msg, showAlert: $viewModel.showAlert)
    }
}

#Preview ("Light mode - EN"){
    CharacterListView(viewModel: .preview,
                      createCharacterDetailView: CharacterDetailFactory(container: DependencyContainer()))
    .preferredColorScheme(.light)
    .environment(\.locale, Locale(identifier: "en"))
}

#Preview ("Dark mode - EN"){
    CharacterListView(viewModel: .preview,
                      createCharacterDetailView: CharacterDetailFactory(container: DependencyContainer()))
    .preferredColorScheme(.dark)
    .environment(\.locale, Locale(identifier: "en"))
}

#Preview ("Light mode - ES"){
    CharacterListView(viewModel: .preview,
                      createCharacterDetailView: CharacterDetailFactory(container: DependencyContainer()))
    .preferredColorScheme(.light)
    .environment(\.locale, Locale(identifier: "es"))
}

#Preview ("Dark mode - ES"){
    CharacterListView(viewModel: .preview,
                      createCharacterDetailView: CharacterDetailFactory(container: DependencyContainer()))
    .preferredColorScheme(.dark)
    .environment(\.locale, Locale(identifier: "es"))
}
