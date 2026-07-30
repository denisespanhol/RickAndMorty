//
//  EpisodeDetailView.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 29/07/26.
//

import SwiftUI
import NetworkKit
import DSM

struct EpisodeDetailView: View {
    
    @StateObject private var viewModel: EpisodeDetailViewModel
    
    init(episode: Episode) {
        _viewModel = StateObject(wrappedValue: EpisodeDetailViewModel(episode: episode))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                DSMLabel(text: viewModel.episode.name, variant: .title)
                
                DSMLabel(text: viewModel.episodeCode, variant: .body)
                
                Divider()
                
                infoRow(label: "Air Date", value: viewModel.airDate)
                infoRow(label: "Episode", value: viewModel.episodeCode)
                infoRow(label: "Characters", value: viewModel.charactersCount)
            }
            .padding()
        }
        .navigationTitle(viewModel.episode.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func infoRow(label: String, value: String) -> some View {
        HStack {
            DSMLabel(text: label, variant: .caption)
                .foregroundColor(.secondary)
            Spacer()
            DSMLabel(text: value, variant: .body)
        }
    }
}
