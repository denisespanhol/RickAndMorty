//
//  AppState.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 28/07/26.
//

import Foundation
import Combine

final class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
}
