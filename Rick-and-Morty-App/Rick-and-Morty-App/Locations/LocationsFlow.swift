//
//  LocationsFlow.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 20/08/26.
//

import SwiftUI
import NetworkKit

struct LocationsFlow: View {
    
    @StateObject private var coordinator = LocationsCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            LocationListView(coordinator: coordinator)
                .navigationDestination(for: LocationsCoordinator.Route.self) { route in
                    switch route {
                    case .locationDetail(let location):
                        LocationDetailView(location: location)
                    }
                }
        }
    }
}
