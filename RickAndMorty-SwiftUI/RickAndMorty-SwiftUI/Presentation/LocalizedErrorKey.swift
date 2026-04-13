//
//  LocalizedErrorKey.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 12.02.2025.
//

import Foundation

enum LocalizedErrorKey {
    case generic
    case invalidResponse
    case decodingFailed
    case tooManyRequests
    case unknown
    
    var localized: LocalizedStringResource {
        switch self {
        case .generic:
            return LocalizedStringResource(
                "ERROR_CHARACTER_GENERIC",
                defaultValue: "An unexpected error occurred. Please try again.",
                comment: "Generic error message shown when an unknown issue occurs."
            )
        case .invalidResponse:
            return LocalizedStringResource(
                "ERROR_CHARACTER_INVALID_RESPONSE",
                defaultValue: "Invalid response from the server. Please check your connection.",
                comment: "Shown when the server returns an unexpected response."
            )
        case .decodingFailed:
            return LocalizedStringResource(
                "ERROR_CHARACTER_DECODING_FAILED",
                defaultValue: "Failed to process the data. Please try again later.",
                comment: "Shown when the app fails to parse the response data."
            )
        case .tooManyRequests:
            return LocalizedStringResource(
                "ERROR_CHARACTER_TOO_MANY_REQUESTS",
                defaultValue: "Too many requests. Please wait and try again later.",
                comment: "Displayed when the user sends too many requests in a short time."
            )
        case .unknown:
            return LocalizedStringResource(
                "ERROR_CHARACTER_UNKNOWN",
                defaultValue: "An unknown error occurred.",
                comment: "Fallback error message for undefined issues."
            )
        }
    }
}
