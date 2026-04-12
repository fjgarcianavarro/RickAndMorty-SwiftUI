//
//  HTTPClientError.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 01.02.2025.
//

import Foundation

nonisolated enum HTTPClientError: Error {
    case clientError
    case decodingError
    case invalidURL
    case responseError
    case serverError
    case tooManyRequests
    case unknownError
}
