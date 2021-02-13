//
//  Preconditions.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-13.
//

import XCTest
@testable import TestingSwift

class Preconditions: XCTestCase {
    
    // This Unit Test will cause a Run Time error because the Assertion will fail
    // func testStoreBuyingWithoutUser() {
        // Given
        // let store = StorePrecondition()
        
        // When
        // let success = store.buy(product: "War of the Worlds")
        
        // Then
        // XCTAssertFalse(success)
    //}
    
    // Create our own Mock That will subclass Store, then override assert() so that it tracks whether the assertion was successful or not

    func testStoreBuyWithUser() {
        
        // Now have the abillity to control what assertions do
        
        class StoreMock: StorePrecondition {

            var wasAssertionSuccesful = false

            override func assert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) {
                wasAssertionSuccesful = condition()
            }
        }
        
        // Given
        let store = StoreMock()
        
        // When
        _ = store.buy(product: "War of the Worlds")
        
        // Then
        XCTAssertFalse(store.wasAssertionSuccesful)
    }
}
