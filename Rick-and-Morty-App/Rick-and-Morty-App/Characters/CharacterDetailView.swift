//
//  CharacterDetailView.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 28/07/26.
//

import SwiftUI
import NetworkKit
import DSM

struct CharacterDetailView: View {
    
    @StateObject private var viewModel: CharacterDetailViewModel
    
    init(character: Character) {
        _viewModel = StateObject(wrappedValue: CharacterDetailViewModel(character: character))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                AsyncImage(url: viewModel.imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    DSMLoadingView()
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                DSMLabel(text: viewModel.character.name, variant: .title)
                
                DSMLabel(text: viewModel.statusAndSpecies, variant: .body)
                
                Divider()
                
                infoRow(label: "Gender", value: viewModel.character.gender)
                infoRow(label: "Origin", value: viewModel.originName)
                infoRow(label: "Location", value: viewModel.locationName)
                infoRow(label: "Episodes", value: viewModel.episodeCount)
            }
            .padding()
        }
        .navigationTitle(viewModel.character.name)
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
