//
//  CharacterDetailViewModel.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José García Navarro on 12.02.2025.
//

import Foundation

@MainActor
final class CharacterDetailViewModel: ObservableObject {
    private let getCharacterDetailUseCase: GetCharacterDetailUseCaseType
    let downloadImageUseCase: DownloadCharacterImageUseCaseType
    private let errorMapper: CharacterPresentableErrorMapper
    
    @Published var character: CharacterPresentable
    @Published var showAlert = false
    @Published var msg: LocalizedStringResource = LocalizedErrorKey.unknown.localized
    
    init(character: CharacterPresentable, getCharacterDetailUseCase: GetCharacterDetailUseCaseType, downloadImageUseCase: DownloadCharacterImageUseCaseType, errorMapper: CharacterPresentableErrorMapper) {
        self.character = character
        self.getCharacterDetailUseCase = getCharacterDetailUseCase
        self.downloadImageUseCase = downloadImageUseCase
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        Task {
            await fetchCharacter()
        }
    }
    
    private func fetchCharacter() async {
        let result = await getCharacterDetailUseCase.execute(id: character.id)
        
        guard case .success(let character) = result else {
            handleError(error: result.failureValue as? CharacterDomainError)
            return
        }
        
        let characterPortable = CharacterPresentable(domainModel: character)
        
        self.character = characterPortable
    }
    
    private func handleError(error: CharacterDomainError?) {
        self.showAlert = true
        self.msg = errorMapper.map(error: error)
    }
}
