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
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func fetchCharacters() async {
        state = .loading
        
        do {
            let response = try await apiClient.fetchCharacters()
            state = .success(response.results)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
