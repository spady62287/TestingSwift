//
//  MockTests.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-12.
//

import XCTest
@testable import TestingSwift

class MockTests: XCTestCase {
    
    func testViewingHomeAddsOneToViewings() {
        // Given
        let home = Home()
        
        // When
        home.conductingViewing()
        
        // Then
        XCTAssertEqual(home.numberOfViewings, 1)
    }
    
    func testViewingHomeAddsOneToViewingsWithVariable() {
        // Given
        let home = Home()
        let startViewings = home.numberOfViewings
        
        // When
        home.conductingViewing()
        
        // Then
        XCTAssertEqual(home.numberOfViewings, startViewings + 1)
    }
    
    // Testing Buyer is trickier: We want to be able to test that viewing a Home correctly adds 1 to the viewing count, but we don't want the internal implementation of Home to get in the way.
    
    // The solution here is to create a protocol that Home conforms to so that we can put a test double in its place.
    
    func testBuyerViewingHomeAddsOneToViewings() {
        // Home mock should look exactly like the Home Objected and conform to it's protocol
        
        // House Mock
        class HomeMock: HomeProtocol {
            var numberOfViewings = 0
            
            func conductViewing() {
                numberOfViewings += 1
            }
        }
        
        // Write a test for Buyer, using the mock than a real house:
        
        // Home Mock is effectively acting like a flight recorder - it tracks what's happening for us so we can check the sequence of events more easily.
        
        // Given
        let buyer = BuyerProtoExample()
        let homeMock = HomeMock()
        
        // When
        buyer.view(homeMock)
        
        // Then
        XCTAssertEqual(homeMock.numberOfViewings, 1)
    }
    
    func testBuyerViewingHomeOnSecondProtocol() {
        
        // Second Home Mock
        class HomeMockTwo: HomeProtocolTwo {
            var conductingViewisCalled = 0
            func conductingViewing() {
                conductingViewisCalled += 1
                print("The buyer looked at the house")
            }
        }
        
        // Given
        let buyer = BuyerProtoExampleTwo()
        let homeMock = HomeMockTwo()
        
        // When
        buyer.view(homeMock)
        
        // Then
        
        // Add a boolean or use a Int value to determined if the method was called, and maybe how man times the method has been called
        
        // XCTAssertTrue(homeMock.conductingViewisCalled)
        XCTAssertEqual(homeMock.conductingViewisCalled, 1)
    }
}
