//
//  AssertArrayTest.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-03.
//

import XCTest
@testable import TestingSwift

class AssertArrayTest: XCTestCase {
    
    func testBuildCity() {
        // Given
        var player = Player(nation: "USA")
        let initialCities = player.cities.count
        
        // When
        player.buildCity(name: "London")
        
        // Then
        XCTAssertEqual(player.cities.count, initialCities + 1)
    }
    
    func testDeclareWar() {
        // Given
        var humanPlayer = Player(nation: "Romans")
        let computer1 = Player(nation: "Babylonians")
        let computer2 = Player(nation: "Vikings")
        
        // When
        humanPlayer.declareWar(target: computer1)
        humanPlayer.declareWar(target: computer2)
        
        // Then
        // Purposely Change the order of the Array to create a failure
        // XCTAssertEqual(humanPlayer.enemies, [computer2, computer1])
        
        // Use Array Extension to Test
        XCTAssertTrue(humanPlayer.enemies.fuzzyMatches(other: [computer2, computer1]))
    }
}
