//
//  CharacterListFactory.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 01.02.2025.
//

import Foundation

final class CharacterListFactory {
    static func create(container: DependencyContainer) -> CharacterListView {
        CharacterListView(viewModel: createViewModel(container: container),
                          createCharacterDetailView: CharacterDetailFactory(container: container))
    }

    private static func createViewModel(container: DependencyContainer) -> CharacterListViewModel {
        CharacterListViewModel(getAllCharactersUseCase: createUseCase(container: container),
                               downloadImageUseCase: createDownloadImageUseCase(container: container),
                               errorMapper: CharacterPresentableErrorMapper())
    }

    private static func createUseCase(container: DependencyContainer) -> GetAllCharactersUseCaseType {
        GetAllCharactersUseCase(repository: createRepository(container: container))
    }

    private static func createRepository(container: DependencyContainer) -> CharacterRepositoryType {
        CharacterRepository(characterRemoteDataSource: RemoteDataSource(httpClient: createHttpClient()),
                            domainMapper: CharacterDomainMapper(),
                            errorMapper: CharacterDomainErrorMapper(),
                            cacheDatasource: createCacheDataSource(container: container))
    }

    private static func createCacheDataSource(container: DependencyContainer) -> CharacterListCacheDataSourceType {
        CompositeCharacterListCacheDataSource(temporalCache: container.inMemoryCharacterListCache,
                                              persistenceCache: PersistentCharacterListCacheDataSource(storage: container.characterListStorage,
                                                                                                      mapper: container.storageDTOMapper))
    }

    private static func createDownloadImageUseCase(container: DependencyContainer) -> DownloadCharacterImageUseCaseType {
        DownloadCharacterImageUseCase(
            repository: CharacterImageRepository(
                characterImageRemoteDataSource: CharacterImageRemoteDataSource(httpClient: createHttpClient()),
                cacheDataSource: container.characterImageCache,
                errorMapper: CharacterImageErrorMapper()
            )
        )
    }

    private static func createHttpClient() -> HTTPClient {
        URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                             errorResolver: URLSessionErrorResolver())
    }
}
