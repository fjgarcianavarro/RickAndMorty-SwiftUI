//
//  DownloadCharacterImageUseCaseStub.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 13.04.2026.
//

import Foundation
@testable import RickAndMorty_SwiftUI

final class DownloadCharacterImageUseCaseStub: DownloadCharacterImageUseCaseType {
    private let result: Result<Data, CharacterImageError>

    init(result: Result<Data, CharacterImageError>) {
        self.result = result
    }

    func execute(url: URL) async -> Result<Data, CharacterImageError> {
        return result
    }
}
