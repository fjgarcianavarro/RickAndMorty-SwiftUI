//
//  URLSessionErrorResolver.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 01.02.2025.
//

import Foundation

final class URLSessionErrorResolver {
    func resolve(statusCode: Int) -> HTTPClientError {
        guard statusCode != 429 else {
            return .tooManyRequests
        }
        
        guard statusCode >= 500 else {
            return .clientError
        }
        
        return .serverError
    }
    
    func resolve(error: Error) -> HTTPClientError {
        return .unknownError
    }
}
