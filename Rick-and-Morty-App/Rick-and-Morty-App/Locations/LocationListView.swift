//
//  LocationListView.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 29/07/26.
//

import SwiftUI
import NetworkKit
import DSM

struct LocationListView: View {
    
    @StateObject private var viewModel = LocationListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                content
            }
            .navigationTitle("Locations")
        }
        .task {
            await viewModel.fetchLocations()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
            
        case .loading:
            DSMLoadingView()
            
        case .success(let locations):
            List(locations) { location in
                NavigationLink(destination: LocationDetailView(location: location)) {
                    DSMCell(
                        title: location.name,
                        subtitle: "\(location.type) · \(location.dimension)"
                    )
                }
            }
            .listStyle(.plain)
            
        case .failure(let message):
            DSMErrorView(viewModel: DSMErrorViewModel(
                message: message,
                onRetry: {
                    Task { await viewModel.fetchLocations() }
                }
            ))
        }
    }
}
