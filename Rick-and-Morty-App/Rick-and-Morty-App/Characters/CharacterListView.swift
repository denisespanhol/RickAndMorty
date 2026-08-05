//
//  CharacterListView.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 28/07/26.
//

import SwiftUI
import NetworkKit
import DSM

struct CharacterListView: View {
    
    @StateObject private var viewModel = CharacterListViewModel()
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationStack {
            Group {
                content
            }
            .navigationTitle("Characters")
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
            await viewModel.fetchCharacters()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
            
        case .loading:
            DSMLoadingView()
            
        case .success(let characters):
            List {
                ForEach(characters) { character in
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        DSMCell(
                            title: character.name,
                            subtitle: "\(character.status) · \(character.species)",
                            imageURL: URL(string: character.image)
                        )
                    }
                }
                
                if viewModel.hasMorePages {
                    HStack {
                        Spacer()
                        if viewModel.isLoadingMore {
                            ProgressView()
                        } else {
                            DSMButton(title: "Load More") {
                                Task { await viewModel.loadNextBatch() }
                            }
                            .frame(maxWidth: 160)
                        }
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 8)
                }
            }
            .listStyle(.plain)
            
        case .failure(let message):
            DSMErrorView(viewModel: DSMErrorViewModel(
                message: message,
                onRetry: {
                    Task { await viewModel.fetchCharacters() }
                }
            ))
        }
    }
    
    
}
