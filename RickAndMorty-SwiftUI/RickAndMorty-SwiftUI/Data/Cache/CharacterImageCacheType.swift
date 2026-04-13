//
//  CharacterImageCacheType.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 09.04.2026.
//

import Foundation

protocol CharacterImageCacheType: Sendable {
    func saveImage(_ data: Data, for url: URL) async
    func cachedOrRegister(for url: URL, task: Task<Data?, Never>) async -> ImageCacheLookup
}
