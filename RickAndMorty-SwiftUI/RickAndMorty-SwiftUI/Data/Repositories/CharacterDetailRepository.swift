//
//  CharacterDetailRepository.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 12.02.2025.
//

import Foundation

final class CharacterDetailRepository: CharacterDetailRepositoryType {
    private let characterDetailRemoteDataSource: CharacterDetailRemoteDataSourceType
    private let domainMapper: CharacterDomainMapper
    private let errorMapper: CharacterDomainErrorMapper
    private let cacheDatasource: CharacterCacheDataSourceType
    
    init(characterDetailRemoteDataSource: CharacterDetailRemoteDataSourceType,
         domainMapper: CharacterDomainMapper,
         errorMapper: CharacterDomainErrorMapper,
         cacheDatasource: CharacterCacheDataSourceType) {
        self.characterDetailRemoteDataSource = characterDetailRemoteDataSource
        self.domainMapper = domainMapper
        self.errorMapper = errorMapper
        self.cacheDatasource = cacheDatasource
    }
    
    func getCharacterDetail(id: String) async -> Result<CharacterEntity, CharacterDomainError> {
        guard let characterID = Int(id) else {
            return .failure(.invalidResponse)
        }
        
        if let characterCache = await cacheDatasource.getCharacter(id: characterID) {
            return .success(characterCache)
        }
        
        let characterResult = await characterDetailRemoteDataSource.getCharacter(id: characterID)
        
        guard case .success(let characterDTO) = characterResult else {
            return .failure(errorMapper.map(error: characterResult.failureValue as? HTTPClientError))
        }
        
        let characterDomain = domainMapper.map(character: characterDTO)
        
        await cacheDatasource.saveCharacter(character: characterDomain)
        
        return .success(characterDomain)
    }
}
