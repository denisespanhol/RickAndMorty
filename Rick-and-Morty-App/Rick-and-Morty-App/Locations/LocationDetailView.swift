//
//  LocationDetailView.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 29/07/26.
//

import SwiftUI
import NetworkKit
import DSM

struct LocationDetailView: View {
    
    @StateObject private var viewModel: LocationDetailViewModel
    
    init(location: Location) {
        _viewModel = StateObject(wrappedValue: LocationDetailViewModel(location: location))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                DSMLabel(text: viewModel.location.name, variant: .title)
                
                DSMLabel(text: viewModel.typeAndDimension, variant: .body)
                
                Divider()
                
                infoRow(label: "Type", value: viewModel.location.type)
                infoRow(label: "Dimension", value: viewModel.location.dimension)
                infoRow(label: "Residents", value: viewModel.residentsCount)
            }
            .padding()
        }
        .navigationTitle(viewModel.location.name)
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
