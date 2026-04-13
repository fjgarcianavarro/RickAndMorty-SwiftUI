//
//  View+Modifiers.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 03.02.2025.
//

import SwiftUI

extension View {
    func customAlert(message: LocalizedStringResource, showAlert: Binding<Bool>) -> some View {
        modifier(AlertModifier(message: message, showAlert: showAlert))
    }
}
