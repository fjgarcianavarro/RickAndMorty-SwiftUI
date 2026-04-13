//
//  BottomNameView.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 03.02.2025.
//

import SwiftUI

struct BottomNameView: View {
    let name: String
    
    var body: some View {
        Rectangle()
            .fill(.white.opacity(0.7))
            .frame(height: 50)
            .overlay(alignment: .top) {
                VStack {
                    Text(name)
                        .font(.rmCharacterNameList)
                        .foregroundStyle(.black)
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)
                        .multilineTextAlignment(.center)
                }
                .padding(2)
            }
    }
}

#Preview {
    BottomNameView(name: CharacterPresentable.preview.name)
}
