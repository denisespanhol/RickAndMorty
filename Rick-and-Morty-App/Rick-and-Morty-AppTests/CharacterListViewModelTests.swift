//
//  CharacterListViewModelTests.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 31/07/26.
//

import XCTest
@testable import Rick_and_Morty_App
import NetworkKit

@MainActor
final class CharacterListViewModelTests: XCTestCase {
    
    private var mock: MockAPIClient!
    private var sut: CharacterListViewModel!
    
    override func setUp() {
        super.setUp()
        mock = MockAPIClient()
        sut = CharacterListViewModel(apiClient: mock)
    }
    
    override func tearDown() {
        mock = nil
        sut = nil
        super.tearDown()
    }
    
    func test_initialState_isIdle() {
        if case .idle = sut.state { } else {
            XCTFail("Initial state should be .idle")
        }
    }
    
    func test_fetchCharacters_success_returnsCharacters() async {
        mock.charactersToReturn = [.mock(name: "Rick Sanchez"), .mock(id: 2, name: "Morty Smith")]
        
        await sut.fetchCharacters()
        
        if case .success(let characters) = sut.state {
            XCTAssertEqual(characters.count, 2)
            XCTAssertEqual(characters.first?.name, "Rick Sanchez")
        } else {
            XCTFail("Waited state was .success")
        }
    }
    
    func test_fetchCharacters_failure_returnsErrorMessage() async {
        mock.errorToThrow = URLError(.notConnectedToInternet)
        
        await sut.fetchCharacters()
        
        if case .failure(let message) = sut.state {
            XCTAssertFalse(message.isEmpty)
        } else {
            XCTFail("Waited state was .failure")
        }
    }
    
    func test_fetchCharacters_emptyList_returnsEmptySuccess() async {
        mock.charactersToReturn = []
        
        await sut.fetchCharacters()
        
        if case .success(let characters) = sut.state {
            XCTAssertEqual(characters.count, 0)
        } else {
            XCTFail("Waited state was .success with empty list")
        }
    }
}
