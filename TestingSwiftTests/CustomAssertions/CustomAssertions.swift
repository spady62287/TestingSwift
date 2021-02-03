//
//  CustomAssertions.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-03.
//

import XCTest
@testable import TestingSwift

class CustomAssertions: XCTestCase {
    
    var sut: Converter!

    override func setUpWithError() throws {
        sut = Converter()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // Verification Method to support multiple Assertions
    // Method takes a tuple as input
    func verifyDivision(_ result: (quotient: Int, remainder: Int), expectedQuotient: Int, expectedRemainder: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(result.quotient, expectedQuotient, file: file, line: line)
        XCTAssertEqual(result.remainder, expectedRemainder, file: file, line: line)
    }
    
    // Test that uses 2 assertions to unit test a tuple
    func testQuotientAndRemainder() {
        // Given
        let dividend = 10
        let divisor = 3
        
        // When
        let result = sut.divisionRemainder(of: dividend, dividedBy: divisor)
        
        // Then
        // XCTAssertEqual(result.quotient, 3)
        // XCTAssertEqual(result.remainder, 1)
        
        // Use function that handles both values in result
//        verifyDivision(result, expectedQuotient: 3, expectedRemainder: 2)
        
        // Add parameters to the Function to reveals where in the file and the line the actual test failed
        verifyDivision(result, expectedQuotient: 3, expectedRemainder: 1)
    }
    
}
