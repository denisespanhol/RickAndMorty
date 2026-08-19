//
//  EpisodesFlow.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 19/08/26.
//

import SwiftUI
import NetworkKit

struct EpisodesFlow: View {
    
    @StateObject private var coordinator = EpisodesCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            EpisodeListView(coordinator: coordinator)
                .navigationDestination(for: EpisodesCoordinator.Route.self) { route in
                    switch route {
                    case .episodeDetail(let episode):
                        EpisodeDetailView(episode: episode)
                    }
                }
        }
    }
}
