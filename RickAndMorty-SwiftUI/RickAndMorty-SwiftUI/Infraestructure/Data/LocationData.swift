//
//  LocationData.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 05.02.2025.
//

import Foundation
import SwiftData

@Model
nonisolated final class LocationData {
    var name: String
    var url: String?

    init(name: String, url: String?) {
        self.name = name
        self.url = url
    }
}
