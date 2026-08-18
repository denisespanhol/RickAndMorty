//
//  CharactersFlow.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 18/08/26.
//

import SwiftUI
import NetworkKit

struct CharactersFlow: View {
    
    @StateObject private var coordinator = CharactersCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            CharacterListView(coordinator: coordinator)
        }
        .navigationDestination(for: CharactersCoordinator.Route.self) { route in
            switch route {
            case .characterDetail(let character):
                CharacterDetailView(character: character)
            }
        }
    }
}
