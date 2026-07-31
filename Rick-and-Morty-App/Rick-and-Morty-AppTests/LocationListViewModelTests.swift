//
//  LocationListViewModelTests.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 31/07/26.
//

import XCTest
@testable import Rick_and_Morty_App
import NetworkKit

@MainActor
final class LocationListViewModelTests: XCTestCase {
    
    private var mock: MockAPIClient!
    private var sut: LocationListViewModel!
    
    override func setUp() {
        super.setUp()
        mock = MockAPIClient()
        sut = LocationListViewModel(apiClient: mock)
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
    
    func test_fetchLocations_success_returnsLocations() async {
        mock.locationsToReturn = [.mock(name: "Earth (C-137)"), .mock(id: 2, name: "Citadel of Ricks")]
        
        await sut.fetchLocations()
        
        if case .success(let locations) = sut.state {
            XCTAssertEqual(locations.count, 2)
            XCTAssertEqual(locations.first?.name, "Earth (C-137)")
        } else {
            XCTFail("Waited state was .success")
        }
    }
    
    func test_fetchLocations_failure_returnsErrorMessage() async {
        mock.errorToThrow = URLError(.timedOut)
        
        await sut.fetchLocations()
        
        if case .failure(let message) = sut.state {
            XCTAssertFalse(message.isEmpty)
        } else {
            XCTFail("Waited state was .failure")
        }
    }
}
