//
//  MockAPIClient.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 31/07/26.
//

import Foundation
import NetworkKit

@MainActor
final class MockAPIClient: APIClientProtocol {
    
    var charactersToReturn: [Character] = []
    var locationsToReturn: [Location] = []
    var episodesToReturn: [Episode] = []
    var errorToThrow: Error?
    
    private func makeResponse<T>(_ results: [T]) -> APIResponse<T> {
        APIResponse(
            info: RMPageInfo(count: results.count, pages: 1, next: nil, prev: nil),
            results: results
        )
    }
    
    func fetchCharacters(page: Int) async throws -> APIResponse<Character> {
        if let error = errorToThrow { throw error }
        return makeResponse(charactersToReturn)
    }
    
    func fetchCharacter(id: Int) async throws -> Character {
        if let error = errorToThrow { throw error }
        return charactersToReturn.first!
    }
    
    func fetchLocations() async throws -> APIResponse<Location> {
        if let error = errorToThrow { throw error }
        return makeResponse(locationsToReturn)
    }
    
    func fetchLocation(id: Int) async throws -> Location {
        if let error = errorToThrow { throw error }
        return locationsToReturn.first!
    }
    
    func fetchEpisodes() async throws -> APIResponse<Episode> {
        if let error = errorToThrow { throw error }
        return makeResponse(episodesToReturn)
    }
    
    func fetchEpisode(id: Int) async throws -> Episode {
        if let error = errorToThrow { throw error }
        return episodesToReturn.first!
    }
}
