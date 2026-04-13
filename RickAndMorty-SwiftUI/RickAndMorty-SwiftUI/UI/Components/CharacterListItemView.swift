//
//  CharacterListItemView.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 14.02.2025.
//

import SwiftUI

struct CharacterListItemView: View {
    let character: CharacterPresentable
    let downloadImageUseCase: DownloadCharacterImageUseCaseType
    
    var body: some View {
        HStack {
            Text(character.name)
                .font(.rmCharacterNameList)
            Spacer()
            CharacterImageView(character: character,
                               isExpanded: false,
                               showOverlay: false,
                               downloadImageUseCase: downloadImageUseCase)
        }
    }
}

#Preview {
    CharacterListItemView(character: .preview, downloadImageUseCase: DownloadCharacterImageUseCasePreview())
        .padding()
}
