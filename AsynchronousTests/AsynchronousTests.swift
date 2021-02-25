//
//  AsynchronousTests.swift
//  AsynchronousTests
//
//  Created by Daniel Spady on 2021-02-03.
//

import XCTest
@testable import TestingSwift

class AsynchronousTests: XCTestCase {
    
    func testPrimesUpTo100ShouldBe0() {
        // Given
        let maximumCount = 100
        
        // When
        PrimeCalculator.calculate(upTo: maximumCount) {
            // Then
            XCTAssertEqual($0.count, 25)
        }
    }
    
    func testPrimesUpTo100ShouldBe25() {
        // Given
        let maximumCount = 100
        let expectation = XCTestExpectation(description: "Calculate primes up to \(maximumCount)")
        
        // When
        PrimeCalculator.calculate(upTo: maximumCount) {
            XCTAssertEqual($0.count, 25)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    func testPrimesUpTo100ShouldBe25Streaming() {
        // Given
        let maximumCount = 100
        let expectation = XCTestExpectation(description: "Calculate primes up to \(maximumCount)")
        expectation.expectedFulfillmentCount = 25
        
        // When
        PrimeCalculator.calculateStreaming(upTo: maximumCount) { _ in
            expectation.fulfill()
        }
        
        // Completion block should be called 25 times
        wait(for: [expectation], timeout: 3)
    }
    
    // Checks that primes are sent back in the correct order
    func testPrimesUpTo100ShouldBe25ManualPrimes() {
        // Given
        let maximumCount = 100
        let primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
        var primeCounter = 0
        
        let expectation = XCTestExpectation(description: "Calculate primes up to \(maximumCount)")
        
        expectation.expectedFulfillmentCount = 25
        
        // When
        PrimeCalculator.calculateStreaming(upTo: maximumCount) { number in
            XCTAssertEqual(primes[primeCounter], number)
            expectation.fulfill()
            primeCounter += 1
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    // That return progress line will be hit almost immediately, because it happens on the main thread while the actual prime number calculation is happening. That gives us the value to feed into XCTNAPredicateExpectation, so now we can rewrite our test to use it
    
    func testPrimesUpTo100Shouldbe25Progress() {
        // Given
        let maximumCount = 100
        
        // When
        let progress = PrimeCalculator.calculateWithProgress(upTo: maximumCount) {
            XCTAssertEqual($0.count, 25)
        }
        
        // Then
        let predicate = NSPredicate(format: "%@.completedUnitCount == %@", argumentArray: [progress, maximumCount])
        
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: progress)
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testUserUpgradedPostNotification() {
        // Given
        let user = User()
        let expectation = XCTNSNotificationExpectation(name: User.upgradeNotification)
        
        // When
        user.upgrade()
        
        // Then
        wait(for: [expectation], timeout: 3)
    }
    
    func testMultiLevelUpgradedPostNotification() {
        // Given
        let multiLevelUser = MultiLevelUser()
        let expectation = XCTNSNotificationExpectation(name: MultiLevelUser.upgradeNotification)
        
        expectation.handler = { notification -> Bool in
            guard let level = notification.userInfo?["level"] as? String else {
                return false
            }
            
            if level == "gold" {
                return true
            } else {
                return false
            }
        }
        
        // When
        multiLevelUser.upgradeUserGold()
        
        // Then
        wait(for: [expectation], timeout: 3)
    }
}
