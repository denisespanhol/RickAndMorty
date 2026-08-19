//
//  EpisodesCoordinator.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 19/08/26.
//

import SwiftUI
import NetworkKit
import Combine

final class EpisodesCoordinator: ObservableObject {
    enum Route: Hashable {
        case episodeDetail(Episode)
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
