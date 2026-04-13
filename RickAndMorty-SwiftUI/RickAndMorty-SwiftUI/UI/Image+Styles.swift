//
//  Image+Styles.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 09.02.2025.
//

import SwiftUI

extension Image {
    func characterImageStyle(
        width: CGFloat,
        height: CGFloat,
        characterName: String,
        showOverlay: Bool
    ) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .overlay(alignment: .bottom) {
                if showOverlay {
                    BottomNameView(name: characterName)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
    }
}
