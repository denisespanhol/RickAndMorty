//
//  AppCoordinator.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 18/08/26.
//

import SwiftUI
import LoginModule
import Combine

final class AppCoordinator: ObservableObject, LoginModuleDelegate {
    
    @Published var isLoggedIn: Bool = false
    
    func loginDidSucceed() {
        DispatchQueue.main.async {
            self.isLoggedIn = true
        }
    }
    
    func loginDidFail(error: Error) {
        print("Login failed: \(error.localizedDescription)")
    }
    
    func logout() {
        isLoggedIn = false
    }
}
