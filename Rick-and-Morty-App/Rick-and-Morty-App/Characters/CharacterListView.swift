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
    
    var body: some View {
        NavigationStack {
            Group {
                content
            }
            .navigationTitle("Characters")
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
            List(characters) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    DSMCell(
                        title: character.name,
                        subtitle: "\(character.status) · \(character.species)",
                        imageURL: URL(string: character.image)
                    )
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
