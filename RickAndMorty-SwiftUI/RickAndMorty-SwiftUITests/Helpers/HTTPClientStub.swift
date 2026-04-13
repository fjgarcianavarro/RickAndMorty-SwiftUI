//
//  HTTPCLientStub.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 06.02.2025.
//

import Foundation
@testable import RickAndMorty_SwiftUI

final class HTTPClientStub: HTTPClient {
    private let result: Result<Data, HTTPClientError>
    
    init(result: Result<Data, HTTPClientError>) {
        self.result = result
    }
    
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        result
    }
    
    func download(from url: URL) async -> Result<Data, HTTPClientError> {
        .failure(.unknownError)
    }
}
