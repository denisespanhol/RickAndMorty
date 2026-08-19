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
    let coordinator: EpisodesCoordinator
    
    var body: some View {
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
            List {
                ForEach(episodes.indices, id: \.self) { index in
                    Button {
                        coordinator.navigate(to: .episodeDetail(episodes[index]))
                    } label: {
                        DSMCell(
                            title: episodes[index].name,
                            subtitle: "\(episodes[index].episode) · \(episodes[index].airDate)",
                            placeholderColor: DSMColors.cyclingColor(for: index)
                        )
                    }
                    .buttonStyle(.plain)
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
