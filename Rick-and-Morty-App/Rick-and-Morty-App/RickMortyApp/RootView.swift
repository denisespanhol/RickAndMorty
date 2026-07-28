//
//  RootView.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 28/07/26.
//

import SwiftUI
import LoginModule

struct RootView: View {
    
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        if appState.isLoggedIn {
            //HomeView()
        } else {
            LoginModule.makeLoginView(delegate: LoginDelegate(appState: appState))
        }
    }
}

final class LoginDelegate: LoginModuleDelegate {
    
    private let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func loginDidSucceed() {
        DispatchQueue.main.async {
            self.appState.isLoggedIn = true
        }
    }
    
    func loginDidFail(error: Error) {
        print("Login falhou: \(error.localizedDescription)")
    }
}
