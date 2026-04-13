//
//  CharacterListTypeSwitcherView.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 14.02.2025.
//

import SwiftUI

struct CharacterListTypeSwitcherView: ToolbarContent {
    @Binding var typeList: CharacterListDisplayMode
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                Button {
                    self.typeList = .grid
                } label: {
                    Label {
                        Text("Grid View", comment: "Label for the button that switches the character list to a grid layout")
                    } icon: {
                        Image(systemName: "square.grid.2x2")
                    }
                }
                
                Button {
                    self.typeList = .list
                } label: {
                    Label {
                        Text("List View", comment: "Label for the button that switches the character list to a list layout.")
                    } icon: {
                        Image(systemName: "list.bullet")
                    }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
        }
    }
}

#Preview {
    struct CharacterListTypeSwitcherPreview: View {
        @State var typeList: CharacterListDisplayMode = .list
        
        var body: some View {
            NavigationStack {
                Text("Hello World!", comment: "This text is only used for SwiftUI previews and should not be considered for localization.")
                    .toolbar {
                        CharacterListTypeSwitcherView(typeList: $typeList)
                    }
            }
        }
    }
    
    return CharacterListTypeSwitcherPreview()
}
