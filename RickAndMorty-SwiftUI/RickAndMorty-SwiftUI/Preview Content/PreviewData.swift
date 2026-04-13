//
//  PreviewData.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 01.02.2025.
//

import Foundation
import UIKit

extension CharacterDetailViewModel {
    static let preview = CharacterDetailViewModel(character: .preview,
                                                  getCharacterDetailUseCase: GetCharacterDetailUseCase(repository: CharacterDetailRepository(characterDetailRemoteDataSource: CharacterDetailRemoteDataSourcePreview(),
                                                                                                                                             domainMapper: CharacterDomainMapper(),
                                                                                                                                             errorMapper: CharacterDomainErrorMapper(),
                                                                                                                                             cacheDatasource: CharacterCacheDataSourcePreview())),
                                                  downloadImageUseCase: DownloadCharacterImageUseCasePreview(),
                                                  errorMapper: CharacterPresentableErrorMapper())
}

extension CharacterListViewModel {
    static let preview: CharacterListViewModel = {
        let repository = CharacterRepository(characterRemoteDataSource: CharacterRemoteDataSourcePreview(),
                                              domainMapper: CharacterDomainMapper(),
                                              errorMapper: CharacterDomainErrorMapper(),
                                              cacheDatasource: CharacterListCacheDataSourcePreview(),
                                              searchCache: TTLInMemorySearchCacheDataSource())
        return CharacterListViewModel(getAllCharactersUseCase: GetAllCharactersUseCase(repository: repository),
                                      searchCharactersUseCase: SearchCharactersUseCase(repository: repository),
                                      downloadImageUseCase: DownloadCharacterImageUseCasePreview(),
                                      errorMapper: CharacterPresentableErrorMapper())
    }()
}

extension CharacterPresentable {
    static let preview = CharacterPresentable(domainModel: .generatePreviewCharacter())
}

extension CharacterEntity {
    static func generatePreviewCharacter() -> CharacterEntity {
        return CharacterEntity(
            id: UUID().uuidString.hashValue,
            name: "Rick Sanchez",
            status: .alive,
            species: "Human",
            type: "Genetic experiment",
            gender: .male,
            origin: .preview,
            location: .preview,
            imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
            episodes: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2",
                "https://rickandmortyapi.com/api/episode/3",
                "https://rickandmortyapi.com/api/episode/4",
            ]
        )
    }
}

extension LocationEntity {
    static let preview = LocationEntity(name: "Earth (C-137)",
                                        url: URL(string: "https://rickandmortyapi.com/api/location/1"))
}

extension LocationDTO {
    static let preview = LocationDTO(name: "Earth (C-137)",
                                     url: "https://rickandmortyapi.com/api/location/1")
}

extension CharacterDTO {
    static let preview = CharacterDTO(id: UUID().uuidString.hashValue,
                                      name: "Rick Sanchez",
                                      status: "Alive",
                                      species: "Human",
                                      type: "Genetic experiment",
                                      gender: "Male",
                                      origin: .preview,
                                      location: .preview,
                                      image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                      episode: [
                                        "https://rickandmortyapi.com/api/episode/1",
                                        "https://rickandmortyapi.com/api/episode/2",
                                        "https://rickandmortyapi.com/api/episode/3",
                                        "https://rickandmortyapi.com/api/episode/4",
                                      ],
                                      url: "https://rickandmortyapi.com/api/character/1")
}

final class CharacterDetailRemoteDataSourcePreview: CharacterDetailRemoteDataSourceType {
    func getCharacter(id: Int) async -> Result<CharacterDTO, HTTPClientError> { .success(.preview) }
}

final class CharacterRemoteDataSourcePreview: CharacterListRemoteDataSourceType {
    func getCharacters() async -> Result<[CharacterDTO], HTTPClientError> { .success([]) }
    func searchCharacters(name: String) async -> Result<[CharacterDTO], HTTPClientError> { .success([]) }
}

final class DownloadCharacterImageUseCasePreview: DownloadCharacterImageUseCaseType {
    func execute(url: URL) async -> Result<Data, CharacterImageError> {
        guard let image = UIImage(named: "preview_character"),
              let imageData = image.jpegData(compressionQuality: 1.0) else {
            return .failure(.unknown)
        }
        
        return .success(imageData)
    }
}

final class CharacterListCacheDataSourcePreview: CharacterListCacheDataSourceType {
    func getCharacterList() async -> [CharacterEntity] {
        [
            .generatePreviewCharacter(), .generatePreviewCharacter(),
            .generatePreviewCharacter(), .generatePreviewCharacter(),
            .generatePreviewCharacter(), .generatePreviewCharacter(),
            .generatePreviewCharacter(), .generatePreviewCharacter()
        ]
    }
    
    func saveCharacterList(_ characterList: [CharacterEntity]) async { }
}

final class CharacterCacheDataSourcePreview: CharacterCacheDataSourceType {
    func getCharacter(id: Int) async -> CharacterEntity? { .generatePreviewCharacter() }
    
    func saveCharacter(character: CharacterEntity) async { }
}
