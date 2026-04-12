//
//  CharacterImageCache.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 09.02.2025.
//

import Foundation

enum ImageCacheLookup {
    case hit(Data)
    case inProgress(Task<Data?, Never>)
    case registered
}

actor CharacterImageCache: CharacterImageCacheType {
    private let cache: NSCache<NSURL, NSData> = {
        let cache = NSCache<NSURL, NSData>()
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024
        return cache
    }()
    private var inProgress: [URL: Task<Data?, Never>] = [:]

    init() {}

    func saveImage(_ data: Data, for url: URL) {
        cache.setObject(data as NSData, forKey: url as NSURL)
        inProgress.removeValue(forKey: url)
    }

    func cachedOrRegister(for url: URL, task: Task<Data?, Never>) -> ImageCacheLookup {
        if let data = cache.object(forKey: url as NSURL) as? Data {
            return .hit(data)
        }
        if let existing = inProgress[url] {
            return .inProgress(existing)
        }
        inProgress[url] = task
        return .registered
    }
}
