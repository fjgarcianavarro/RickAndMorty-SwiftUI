//
//  CharacterDetailStackCell.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 14.02.2025.
//

import SwiftUI

struct CharacterDetailStackCell: View {
    let title: LocalizedStringResource
    var value: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.rmDetailTitle)
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
    CharacterDetailStackCell(title: LocalizedStringResource("title",
                                                            comment: "This text is only used for SwiftUI previews and should not be considered for localization."),
                             value: "value")
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding()
}
