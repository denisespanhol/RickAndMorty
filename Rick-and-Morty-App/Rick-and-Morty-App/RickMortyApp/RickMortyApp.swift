//
//  RickMortyApp.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 28/07/26.
//

import SwiftUI
import LoginModule
import FirebaseCore

@main
struct RickMortyApp: App {
    
    @StateObject private var appCoordinator = AppCoordinator()
    @StateObject private var appState = AppState()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appCoordinator)
                .environmentObject(appState)
        }
    }
}
