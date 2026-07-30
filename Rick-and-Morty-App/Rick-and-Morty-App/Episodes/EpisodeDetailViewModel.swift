//
//  EpisodeDetailViewModel.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 29/07/26.
//

import Foundation
import Combine
import NetworkKit

@MainActor
final class EpisodeDetailViewModel: ObservableObject {
    
    let episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
    }
    
    var episodeCode: String {
        episode.episode
    }
    
    var airDate: String {
        episode.airDate
    }
    
    var charactersCount: String {
        "\(episode.characters.count) characters"
    }
}
