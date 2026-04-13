//
//  CharacterDetailCell.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 14.02.2025.
//

import SwiftUI

struct CharacterDetailCell: View {
    let title: LocalizedStringResource
    var value: String?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.rmDetailTitle)
            Spacer()
            if let value {
                Text(value)
                    .font(.rmDetailValue)
            } else {
                Text("--", comment: "Displayed when no value is available for a character's detail.")
                    .font(.rmDetailValue)
            }
        }
    }
}

#Preview {
    CharacterDetailCell(title: LocalizedStringResource("title",
                                                       comment: "This text is only used for SwiftUI previews and should not be considered for localization."),
                        value: "value")
        .padding()
}
