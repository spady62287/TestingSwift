//
//  ThrowingTests.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-03.
//

import XCTest
@testable import TestingSwift

class ThrowingTests: XCTestCase {
    
    func testPlayingBioBlitzThrows() {
        let game = Game(name: GameTitles.bioBlitz.rawValue)
        
        do {
            try game.play()
            XCTFail("\(GameTitles.bioBlitz.rawValue) has not been purchased")
        } catch GameError.notPurchased {
            // Success
        } catch {
            XCTFail("Game has been purchased")
        }
    }
    
    func testPlayingBlastaapThrows() {
        let game = Game(name: GameTitles.blastaap.rawValue)
        XCTAssertThrowsError(try game.play()) { error in
            XCTAssertEqual(error as? GameError, GameError.notInstalled)
        }
    }
    
    func testPlayingExplodingAnimals() {
        let game = Game(name: GameTitles.explodingAnimals.rawValue)
        
        XCTAssertNoThrow(try game.play())
    }
    
    // This test will always throw. This approach is really good idea for tests that aren't designed to throw
    func testDeadStormRisingThrows() throws {
        let game = Game(name: GameTitles.deadStormRising.rawValue)
        // try game.play()
        XCTAssertThrowsError(try game.play())
    }
    
    func testCrashyPlaneDoesntThrow() throws {
        let game = Game(name: GameTitles.crashyPlane.rawValue)
        try game.play()
    }
}
