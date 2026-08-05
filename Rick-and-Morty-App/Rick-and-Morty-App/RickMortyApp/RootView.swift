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

    @EnvironmentObject private var appState: AppState
    @StateObject private var loginDelegate = LoginDelegateHolder()

    var body: some View {
        Group {
            if appState.isLoggedIn {
                HomeView()
            } else {
                LoginModule.makeLoginView(delegate: loginDelegate)
                    .onAppear {
                        loginDelegate.appState = appState
                    }
            }
        }
        .preferredColorScheme(appState.colorScheme)
    }
}

@MainActor
final class LoginDelegateHolder: ObservableObject, LoginModuleDelegate {

    var appState: AppState?

    func loginDidSucceed() {
        DispatchQueue.main.async {
            self.appState?.isLoggedIn = true
        }
    }

    func loginDidFail(error: Error) {
        print("Login failed: \(error.localizedDescription)")
    }
}
