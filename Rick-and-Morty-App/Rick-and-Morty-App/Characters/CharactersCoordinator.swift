//
//  CharactersCoordinator.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 18/08/26.
//

import SwiftUI
import NetworkKit
import Combine

final class CharactersCoordinator: ObservableObject {
    enum Route: Hashable {
        case characterDetail(Character)
    }
    
    @Published var path = NavigationPath()
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func goToRoot() {
        path.removeLast(path.count)
    }
}
