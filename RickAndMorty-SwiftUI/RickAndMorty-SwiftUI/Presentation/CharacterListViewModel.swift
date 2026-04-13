//
//  CharacterListViewModel.swift
//  RickAndMorty-SwiftUI
//
//  Created by Francisco José Navarro García on 01.02.2025.
//

import Foundation

@MainActor
final class CharacterListViewModel: ObservableObject {
    private let getAllCharactersUseCase: GetAllCharactersUseCaseType
    private let searchCharactersUseCase: SearchCharactersUseCaseType
    let downloadImageUseCase: DownloadCharacterImageUseCaseType
    private let errorMapper: CharacterPresentableErrorMapper
    
    @Published var searchText: String = ""
    private var searchTask: Task<Void, Never>?
    @Published var characters: [CharacterPresentable] = []
    @Published var showAlert = false
    @Published var msg: LocalizedStringResource = LocalizedErrorKey.unknown.localized
    @Published var loading = false
    
    init(getAllCharactersUseCase: GetAllCharactersUseCaseType, searchCharactersUseCase: SearchCharactersUseCaseType, downloadImageUseCase: DownloadCharacterImageUseCaseType, errorMapper: CharacterPresentableErrorMapper) {
        self.getAllCharactersUseCase = getAllCharactersUseCase
        self.searchCharactersUseCase = searchCharactersUseCase
        self.downloadImageUseCase = downloadImageUseCase
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        self.loading = true
        
        Task {
            await fetchCharacters()
        }
    }
    
    func refreshData() {
        Task {
            await fetchCharacters()
        }
    }
    
    private func fetchCharacters() async {
        let result = await getAllCharactersUseCase.execute()
        
        guard case .success(let characters) = result else {
            handleError(error: result.failureValue as? CharacterDomainError)
            return
        }
        
        let charactersPortable = characters.map { CharacterPresentable(domainModel: $0) }
        
        self.loading = false
        self.characters = charactersPortable
    }
    
    func onSearchTextChanged(_ query: String) {
        searchTask?.cancel()

        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            Task { await fetchCharacters() }
            return
        }

        searchTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            guard !Task.isCancelled else { return }
            await performSearch(query: query)
        }
    }

    private func performSearch(query: String) async {
        loading = true
        characters = []

        let result = await searchCharactersUseCase.execute(name: query)

        guard !Task.isCancelled else { return }

        loading = false
        switch result {
        case .success(let entities):
            characters = entities.map { CharacterPresentable(domainModel: $0) }
        case .failure(let error):
            handleError(error: error)
        }
    }

    private func handleError(error: CharacterDomainError?) {
        self.loading = false
        self.showAlert = true
        self.msg = errorMapper.map(error: error)
    }
}
