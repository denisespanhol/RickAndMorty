//
//  CharacterDetailViewModel.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 28/07/26.
//

import Foundation
import Combine
import NetworkKit

@MainActor
final class CharacterDetailViewModel: ObservableObject {
    
    let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var statusAndSpecies: String {
        "\(character.status) · \(character.species)"
    }
    
    var originName: String {
        character.origin.name
    }
    
    var locationName: String {
        character.location.name
    }
    
    var episodeCount: String {
        "\(character.episode.count) episodes"
    }
    
    var imageURL: URL? {
        URL(string: character.image)
    }
}
