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
        let game = Game(name: GameTitles.BioBlitz.rawValue)
        
        do {
            try game.play()
            XCTFail("\(GameTitles.BioBlitz.rawValue) has not been purchased")
        } catch GameError.notPurchased {
            // Success
        } catch {
            XCTFail()
        }
    }
    
    func testPlayingBlastaapThrows() {
        let game = Game(name: GameTitles.Blastaap.rawValue)
        XCTAssertThrowsError(try game.play()) { error in
            XCTAssertEqual(error as? GameError, GameError.notInstalled)
        }
    }
    
    func testPlayingExplodingAnimals() {
        let game = Game(name: GameTitles.ExplodingAnimals.rawValue)
        
        XCTAssertNoThrow(try game.play())
    }
    
    // This test will always throw. This approach is really good idea for tests that aren't designed to throw
    func testDeadStormRisingThrows() throws {
        let game = Game(name: GameTitles.DeadStormRising.rawValue)
        //try game.play()
        XCTAssertThrowsError(try game.play())
    }
    
    func testCrashyPlaneDoesntThrow() throws {
        let game = Game(name: GameTitles.CrashyPlane.rawValue)
        try game.play()
    }
}
