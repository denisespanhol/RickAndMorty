//
//  RootView.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 28/07/26.
//

import SwiftUI
import Combine
import LoginModule

struct RootView: View {

    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var appState: AppState

    var body: some View {
        Group {
            if appCoordinator.isLoggedIn {
                HomeView()
            } else {
                LoginModule.makeLoginView(delegate: appCoordinator)
            }
        }
        .preferredColorScheme(appState.colorScheme)
    }
}
