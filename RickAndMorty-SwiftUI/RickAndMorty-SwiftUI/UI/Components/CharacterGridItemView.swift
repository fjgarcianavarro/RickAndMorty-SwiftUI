//
//  CharacterGridItemView.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 14.02.2025.
//

import SwiftUI

struct CharacterGridItemView: View {
    let character: CharacterPresentable
    let downloadImageUseCase: DownloadCharacterImageUseCaseType
    
    var body: some View {
        CharacterImageView(character: character,
                           isExpanded: false,
                           downloadImageUseCase: downloadImageUseCase)
    }
}

#Preview {
    CharacterGridItemView(character: .preview, downloadImageUseCase: DownloadCharacterImageUseCasePreview())
}
