//
//  HTTPClientError.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 01.02.2025.
//

import Foundation

nonisolated enum HTTPClientError: Error {
    case clientError
    case decodingError
    case invalidURL
    case notFound
    case responseError
    case serverError
    case tooManyRequests
    case unknownError
}
