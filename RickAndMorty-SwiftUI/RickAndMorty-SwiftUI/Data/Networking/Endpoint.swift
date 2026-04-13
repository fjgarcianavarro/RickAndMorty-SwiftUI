//
//  Endpoint.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 01.02.2025.
//

import Foundation

struct Endpoint {
    let path: String
    let queryParameters: [String: Any]
    let method: HTTPMethod
}
