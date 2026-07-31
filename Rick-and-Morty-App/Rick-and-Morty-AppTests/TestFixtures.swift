//
//  TestFixtures.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 31/07/26.
//

import Foundation
import NetworkKit

extension Character {
    static func mock(
        id: Int = 1,
        name: String = "Rick Sanchez",
        status: String = "Alive",
        species: String = "Human"
    ) -> Character {
        Character(
            id: id,
            name: name,
            status: status,
            species: species,
            gender: "Male",
            image: "https://example.com/rick.png",
            origin: CharacterLocation(name: "Earth", url: ""),
            location: CharacterLocation(name: "Earth C-137", url: ""),
            episode: ["https://example.com/episode/1"],
            created: "2017-11-04"
        )
    }
}

extension Location {
    static func mock(
        id: Int = 1,
        name: String = "Earth (C-137)",
        type: String = "Planet",
        dimension: String = "Dimension C-137"
    ) -> Location {
        Location(
            id: id,
            name: name,
            type: type,
            dimension: dimension,
            residents: ["https://example.com/character/1"],
            url: "https://example.com/location/1",
            created: "2017-11-10"
        )
    }
}

extension Episode {
    static func mock(
        id: Int = 1,
        name: String = "Pilot",
        airDate: String = "December 2, 2013",
        episode: String = "S01E01"
    ) -> Episode {
        Episode(
            id: id,
            name: name,
            airDate: airDate,
            episode: episode,
            characters: ["https://example.com/character/1"],
            url: "https://example.com/episode/1",
            created: "2017-11-10"
        )
    }
}
