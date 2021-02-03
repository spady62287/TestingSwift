//
//  PerformanceTesting.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-03.
//

import XCTest
@testable import TestingSwift

class PerformanceTesting: XCTestCase {
    
    // Test is only a failure if it performs slower than 10%
    func testPrimePerformance() {
        measure {
            _ = PrimeCalculator.measure(upTo: 1_000_000)
        }
    }
}
