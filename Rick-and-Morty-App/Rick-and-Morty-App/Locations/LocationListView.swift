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
    @EnvironmentObject private var appState: AppState
    let coordinator: LocationsCoordinator
    
    var body: some View {
        Group {
            content
        }
        .navigationTitle("Locations")
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
            List {
                ForEach(locations.indices, id: \.self) { index in
                    Button {
                        coordinator.navigate(to: .locationDetail(locations[index]))
                    } label: {
                        DSMCell(
                            title: locations[index].name,
                            subtitle: "\(locations[index].type) · \(locations[index].dimension)",
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
                    Task { await viewModel.fetchLocations() }
                }
            ))
        }
    }
}
