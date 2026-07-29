//
//  EpisodeListViewModel.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 29/07/26.
//

import Foundation
import Combine
import NetworkKit

@MainActor
final class LocationListViewModel: ObservableObject {
    
    enum ViewState {
        case idle
        case loading
        case success([Location])
        case failure(String)
    }
    
    @Published private(set) var state: ViewState = .idle
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func fetchLocations() async {
        state = .loading
        
        do {
            let response = try await apiClient.fetchLocations()
            state = .success(response.results)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
