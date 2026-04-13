//
//  ModifierPreview.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 11.02.2025.
//

import SwiftUI

struct AlertModifierPreview: View {
    @State private var showAlert = true
    
    var body: some View {
        Text("Hello World!", comment: "This text is only used for SwiftUI previews and should not be considered for localization.")
            .modifier(AlertModifier(message: LocalizedStringResource("Hello, World!",
                                                                     comment: "This text is only used for SwiftUI previews and should not be considered for localization."),
                                    showAlert: $showAlert))
    }
}
