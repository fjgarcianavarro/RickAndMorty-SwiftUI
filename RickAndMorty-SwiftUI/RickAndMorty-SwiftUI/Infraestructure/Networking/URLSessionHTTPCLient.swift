//
//  URLSessionHTTPClient.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 01.02.2025.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    private let requestMaker: URLSessionRequestMaker
    private let errorResolver: URLSessionErrorResolver
    
    init(session: URLSession = .shared, requestMaker: URLSessionRequestMaker, errorResolver: URLSessionErrorResolver) {
        self.session = session
        self.requestMaker = requestMaker
        self.errorResolver = errorResolver
    }
    
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        guard let url = requestMaker.url(endpoint: endpoint,
                                         baseUrl: baseUrl) else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, urlResponse) = try await session.data(from: url)
            
            guard let response = urlResponse as? HTTPURLResponse else {
                return .failure(.responseError)
            }
            
            guard response.statusCode == 200 else {
                return .failure(errorResolver.resolve(statusCode: response.statusCode))
            }
            
            return .success(data)
        } catch {
            return .failure(errorResolver.resolve(error: error))
        }
    }
    
    func download(from url: URL) async -> Result<Data, HTTPClientError> {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                return .failure(.responseError)
            }
            
            return .success(data)
        } catch {
            return .failure(.unknownError)
        }
    }
}
