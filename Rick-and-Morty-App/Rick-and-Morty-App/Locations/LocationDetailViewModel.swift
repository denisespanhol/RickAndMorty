//
//  LocationDetailViewModel.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 29/07/26.
//

import Foundation
import Combine
import NetworkKit

@MainActor
final class LocationDetailViewModel: ObservableObject {
    
    let location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    var typeAndDimension: String {
        "\(location.type) · \(location.dimension)"
    }
    
    var residentsCount: String {
        "\(location.residents.count) residents"
    }
}
