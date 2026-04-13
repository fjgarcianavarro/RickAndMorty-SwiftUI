//
//  CharacterRepository.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 01.02.2025.
//

import Foundation

final class CharacterRepository: CharacterRepositoryType {
    private let characterRemoteDataSource: CharacterListRemoteDataSourceType
    private let domainMapper: CharacterDomainMapper
    private let errorMapper: CharacterDomainErrorMapper
    private let cacheDatasource: CharacterListCacheDataSourceType
    private let searchCache: SearchCacheDataSourceType

    init(characterRemoteDataSource: CharacterListRemoteDataSourceType, domainMapper: CharacterDomainMapper, errorMapper: CharacterDomainErrorMapper, cacheDatasource: CharacterListCacheDataSourceType, searchCache: SearchCacheDataSourceType) {
        self.characterRemoteDataSource = characterRemoteDataSource
        self.domainMapper = domainMapper
        self.errorMapper = errorMapper
        self.cacheDatasource = cacheDatasource
        self.searchCache = searchCache
    }
    
    func getCharacters() async -> Result<[CharacterEntity], CharacterDomainError> {
        let charactersCache = await cacheDatasource.getCharacterList()
        
        if !charactersCache.isEmpty {
            return .success(charactersCache)
        }
        
        let charactersResult = await characterRemoteDataSource.getCharacters()
        
        guard case .success(let characters) = charactersResult else {
            return .failure(errorMapper.map(error: charactersResult.failureValue as? HTTPClientError))
        }
        
        let charactersDomain = domainMapper.map(characterList: characters)
        
        await cacheDatasource.saveCharacterList(charactersDomain)
        
        return .success(charactersDomain)
    }

    func searchCharacters(name: String) async -> Result<[CharacterEntity], CharacterDomainError> {
        if let cached = await searchCache.get(query: name) {
            return .success(cached)
        }

        let result = await characterRemoteDataSource.searchCharacters(name: name)

        guard case .success(let characters) = result else {
            return .failure(errorMapper.map(error: result.failureValue as? HTTPClientError))
        }

        let entities = domainMapper.map(characterList: characters)
        
        await searchCache.save(query: name, characters: entities)
        
        return .success(entities)
    }
}
