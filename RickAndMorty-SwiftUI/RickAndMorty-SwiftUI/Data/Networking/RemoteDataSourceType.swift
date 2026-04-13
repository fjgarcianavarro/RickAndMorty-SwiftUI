//
//  RemoteDataSourceType.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 01.02.2025.
//

import Foundation

protocol CharacterListRemoteDataSourceType: Sendable {
    func getCharacters() async -> Result<[CharacterDTO], HTTPClientError>
    func searchCharacters(name: String) async -> Result<[CharacterDTO], HTTPClientError>
}

protocol CharacterImageRemoteDataSourceType: Sendable {
    func downloadImage(from url: URL) async -> Result<Data, HTTPClientError>
}

protocol CharacterDetailRemoteDataSourceType: Sendable {
    func getCharacter(id: Int) async -> Result<CharacterDTO, HTTPClientError>
}
