//
//  CharacterDetailFactory.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 09.02.2025.
//

import SwiftUI

final class CharacterDetailFactory: CharacterDetailViewFactory {
    private let container: DependencyContainer

    init(container: DependencyContainer) {
        self.container = container
    }

    func create(character: CharacterPresentable) -> CharacterDetailView {
        CharacterDetailView(viewModel: createViewModel(character: character))
    }

    private func createViewModel(character: CharacterPresentable) -> CharacterDetailViewModel {
        CharacterDetailViewModel(character: character,
                                 getCharacterDetailUseCase: createUseCase(),
                                 downloadImageUseCase: createDownloadImageUseCase(),
                                 errorMapper: CharacterPresentableErrorMapper())
    }

    private func createUseCase() -> GetCharacterDetailUseCaseType {
        GetCharacterDetailUseCase(repository: createRepository())
    }

    private func createRepository() -> CharacterDetailRepositoryType {
        CharacterDetailRepository(characterDetailRemoteDataSource: CharacterDetailRemoteDataSource(httpClient: createHttpClient()),
                                  domainMapper: CharacterDomainMapper(),
                                  errorMapper: CharacterDomainErrorMapper(),
                                  cacheDatasource: createCacheDataSource())
    }

    private func createCacheDataSource() -> CharacterCacheDataSourceType {
        CompositeCharacterCacheDataSource(temporalCache: container.inMemoryCharacterCache,
                                          persistenceCache: PersistentCharacterCacheDataSource(storage: container.characterStorage,
                                                                                               mapper: container.storageDTOMapper))
    }

    private func createDownloadImageUseCase() -> DownloadCharacterImageUseCaseType {
        DownloadCharacterImageUseCase(repository: createCharacterImageRepository())
    }

    private func createCharacterImageRepository() -> CharacterImageRepositoryType {
        CharacterImageRepository(characterImageRemoteDataSource: CharacterImageRemoteDataSource(httpClient: createHttpClient()),
                                 cacheDataSource: container.characterImageCache,
                                 errorMapper: CharacterImageErrorMapper())
    }

    private func createHttpClient() -> HTTPClient {
        URLSessionHTTPClient(requestMaker: URLSessionRequestMaker(),
                             errorResolver: URLSessionErrorResolver())
    }
}
