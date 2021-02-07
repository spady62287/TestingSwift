//
//  MutationTesting.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-07.
//

import XCTest
@testable import TestingSwift

class MutationTesting: XCTestCase {
    
    func testThreeIngredientCakeCostsTen() {
        // Given
        let cake = Cake()
        let ingredients = ["chocolate", "cherries", "frosting"]
        
        // When
        let cost = cake.bake(ingredients: ingredients)
        
        // Then
        XCTAssertEqual(cost, 10)
    }
    
    func testFourIngredientCakeCostsThirteen() {
        // Given
        let cake = Cake()
        let ingredients = ["straberry", "blueberry", "peaches", "chocolate"]
        
        // When
        let cost = cake.bake(ingredients: ingredients)
        
        // Then
        XCTAssertEqual(cost, 13)
    }
    
}
