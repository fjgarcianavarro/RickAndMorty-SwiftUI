//
//  Font+Styles.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 11.02.2025.
//

import SwiftUI

extension Font {
    static let rmCharacterNameList = Font.system(.caption, design: .rounded)
        .weight(.bold)
    
    static let rmCharacterNameDetail = Font.system(.title, design: .rounded)
        .weight(.bold)
    
    static let rmLoadingText = Font.system(.headline, design: .rounded)
        .weight(.semibold)
    
    static let rmAlertTitle = Font.system(.title3, design: .rounded)
        .weight(.bold)
    
    static let rmAlertButton = Font.system(.body, design: .rounded)
        .weight(.semibold)
    
    static let rmSectionHeader = Font.system(.headline, design: .rounded)
        .weight(.bold)
    
    static let rmDetailTitle = Font.system(.body, design: .rounded)
        .weight(.semibold)
    
    static let rmDetailValue = Font.system(.body, design: .rounded)
        .weight(.regular)
}
