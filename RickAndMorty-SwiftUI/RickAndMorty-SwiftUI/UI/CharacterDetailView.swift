//
//  CharacterDetailView.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 12.02.2025.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            VStack {
                CharacterImageView(character: viewModel.character,
                                   isExpanded: true,
                                   showOverlay: false,
                                   downloadImageUseCase: viewModel.downloadImageUseCase)
                Text(viewModel.character.name)
                    .font(.rmCharacterNameDetail)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Section {
                CharacterDetailCell(title: LocalizedStringResource("Status",
                                                                   comment: "Label for the character's current status (e.g., Alive, Dead, Unknown)."),
                                    value: viewModel.character.status)
                CharacterDetailCell(title: LocalizedStringResource("Species",
                                                                   comment: "Label for the character's species (e.g., Human, Alien)."),
                                    value: viewModel.character.species)
                CharacterDetailCell(title: LocalizedStringResource("Gender",
                                                                   comment: "Label for the character's gender (e.g., Male, Female, Genderless, Unknown)."),
                                    value: viewModel.character.gender)
                if let type = viewModel.character.type, !type.isEmpty {
                    CharacterDetailCell(title: LocalizedStringResource("Type",
                                                                       comment: "Label for the character's specific type (if available)."),
                                        value: type)
                }
            } header: {
                Text("Character Info", comment: "Section header for character details.")
                    .font(.rmSectionHeader)
            }
            
            Section {
                CharacterDetailStackCell(title: LocalizedStringResource("Origin",
                                                                        comment: "Label for the character's place of origin."),
                                         value: viewModel.character.origin)
                CharacterDetailStackCell(title: LocalizedStringResource("Current Location",
                                                                        comment: "Label for the character's current location in the universe."),
                                         value: viewModel.character.location)
            } header: {
                Text("Locations", comment: "Section header for location-related character details.")
                    .font(.rmSectionHeader)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .customAlert(message: viewModel.msg, showAlert: $viewModel.showAlert)
    }
}

#Preview ("Light mode - EN"){
    CharacterDetailView(viewModel: .preview)
    .preferredColorScheme(.light)
    .environment(\.locale, Locale(identifier: "en"))
}

#Preview ("Dark mode - EN"){
    CharacterDetailView(viewModel: .preview)
    .preferredColorScheme(.dark)
    .environment(\.locale, Locale(identifier: "en"))
}

#Preview ("Light mode - ES"){
    CharacterDetailView(viewModel: .preview)
    .preferredColorScheme(.light)
    .environment(\.locale, Locale(identifier: "es"))
}

#Preview ("Dark mode - ES"){
    CharacterDetailView(viewModel: .preview)
    .preferredColorScheme(.dark)
    .environment(\.locale, Locale(identifier: "es"))
}
