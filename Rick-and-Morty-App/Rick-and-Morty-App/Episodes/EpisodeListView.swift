//
//  EpisodeListView.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 29/07/26.
//

import SwiftUI
import NetworkKit
import DSM

struct EpisodeListView: View {
    
    @StateObject private var viewModel = EpisodeListViewModel()
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationStack {
            Group {
                content
            }
            .navigationTitle("Episodes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        appState.colorScheme = appState.colorScheme == .dark ? nil : .dark
                    } label: {
                        Image(systemName: appState.colorScheme == .dark ? "sun.max.fill" : "moon.fill")
                    }
                }
            }
        }
        .task {
            await viewModel.fetchEpisodes()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
            
        case .loading:
            DSMLoadingView()
            
        case .success(let episodes):
            List(Array(episodes.enumerated()), id: \.element.id) { index, episode in
                NavigationLink(destination: EpisodeDetailView(episode: episode)) {
                    DSMCell(
                        title: episode.name,
                        subtitle: "\(episode.episode) · \(episode.airDate)",
                        placeholderColor: DSMColors.cyclingColor(for: index)
                    )
                }
            }
            .listStyle(.plain)
            
        case .failure(let message):
            DSMErrorView(viewModel: DSMErrorViewModel(
                message: message,
                onRetry: {
                    Task { await viewModel.fetchEpisodes() }
                }
            ))
        }
    }
}
