//
//  CharacterListViewModel.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 28/07/26.
//

import Foundation
import Combine
import NetworkKit

@MainActor
final class CharacterListViewModel: ObservableObject {
    
    enum ViewState {
        case idle
        case loading
        case success([Character])
        case failure(String)
    }
    
    @Published private(set) var state: ViewState = .idle
    @Published private(set) var characters: [Character] = []
    @Published private(set) var hasMorePages = true
    @Published private(set) var isLoadingMore = false
    
    private var nextPage = 1
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func fetchCharacters() async {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        nextPage = 1
        hasMorePages = true
        characters = []
        state = .loading
        await loadBatch()
    }
    
    func loadNextBatch() async {
        guard hasMorePages, !isLoadingMore else { return }
        isLoadingMore = true
        await loadBatch()
    }
    
    private func loadBatch() async {
        do {
            let response = try await apiClient.fetchCharacters(page: nextPage)
            characters.append(contentsOf: response.results)
            nextPage += 1
            hasMorePages = response.info.next != nil
            state = .success(characters)
        } catch {
            state = .failure(error.localizedDescription)
        }
        isLoadingMore = false
    }
}
