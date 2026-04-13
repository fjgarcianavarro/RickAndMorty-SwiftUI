//
//  AlertModifier.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 03.02.2025.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    let message: LocalizedStringResource
    
    @Binding var showAlert: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black.opacity(0.5))
                    
                    VStack(spacing: 16) {
                        Text(message)
                            .font(.rmAlertTitle)
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.center)
                        HStack(spacing: 12) {
                            Button(role: .cancel) {
                                showAlert.toggle()
                            } label: {
                                Text("Cancel", comment: "Button to dismiss the alert without taking action.")
                                    .font(.rmAlertButton)
                            }
                            Button {
                                showAlert.toggle()
                            } label: {
                                Text("OK", comment: "Button to confirm and close the alert.")
                                    .font(.rmAlertButton)
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(white: 0.9))
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
                    }
                    .offset(y: showAlert ? 0.0 : 300)
                }
                .opacity(showAlert ? 1.0 : 0.0)
                .animation(.default, value: showAlert)
                .ignoresSafeArea()
            }
        
    }
}

#Preview ("Light mode"){
    return AlertModifierPreview()
        .preferredColorScheme(.light)
}

#Preview ("Dark mode"){    
    return AlertModifierPreview()
        .preferredColorScheme(.dark)
}
