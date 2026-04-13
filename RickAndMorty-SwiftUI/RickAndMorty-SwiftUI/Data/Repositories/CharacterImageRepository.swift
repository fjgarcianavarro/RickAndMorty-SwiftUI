//
//  CharacterImageRepository.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 08.02.2025.
//

import Foundation

final class CharacterImageRepository: CharacterImageRepositoryType {
    private let characterImageRemoteDataSource: CharacterImageRemoteDataSourceType
    private let characterImageCache: CharacterImageCacheType
    private let errorMapper: CharacterImageErrorMapper

    init(characterImageRemoteDataSource: CharacterImageRemoteDataSourceType, cacheDataSource: CharacterImageCacheType, errorMapper: CharacterImageErrorMapper) {
        self.characterImageRemoteDataSource = characterImageRemoteDataSource
        self.characterImageCache = cacheDataSource
        self.errorMapper = errorMapper
    }

    func getImage(for url: URL) async -> Result<Data, CharacterImageError> {
        let downloadTask = Task<Data?, Never> {
            let result = await characterImageRemoteDataSource.downloadImage(from: url)
            guard case .success(let data) = result else { return nil }
            return data
        }

        switch await characterImageCache.cachedOrRegister(for: url, task: downloadTask) {
        case .hit(let data):
            downloadTask.cancel()
            return .success(data)

        case .inProgress(let existingTask):
            downloadTask.cancel()
            if let data = await existingTask.value {
                return .success(data)
            }
            return .failure(.networkError)

        case .registered:
            guard let characterImage = await downloadTask.value else {
                return .failure(errorMapper.map(error: nil))
            }
            await characterImageCache.saveImage(characterImage, for: url)
            return .success(characterImage)
        }
    }
}
