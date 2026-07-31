//
//  EpisodeListViewModelTests.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 31/07/26.
//

import XCTest
@testable import Rick_and_Morty_App
import NetworkKit

@MainActor
final class EpisodeListViewModelTests: XCTestCase {
    
    private var mock: MockAPIClient!
    private var sut: EpisodeListViewModel!
    
    override func setUp() {
        super.setUp()
        mock = MockAPIClient()
        sut = EpisodeListViewModel(apiClient: mock)
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
    
    func test_fetchEpisodes_success_returnsEpisodes() async {
        mock.episodesToReturn = [.mock(name: "Pilot"), .mock(id: 2, name: "Lawnmower Dog")]
        
        await sut.fetchEpisodes()
        
        if case .success(let episodes) = sut.state {
            XCTAssertEqual(episodes.count, 2)
            XCTAssertEqual(episodes.first?.name, "Pilot")
        } else {
            XCTFail("Waited state was .success")
        }
    }
    
    func test_fetchEpisodes_failure_returnsErrorMessage() async {
        mock.errorToThrow = URLError(.notConnectedToInternet)
        
        await sut.fetchEpisodes()
        
        if case .failure(let message) = sut.state {
            XCTAssertFalse(message.isEmpty)
        } else {
            XCTFail("Waited state was .failure")
        }
    }
}
