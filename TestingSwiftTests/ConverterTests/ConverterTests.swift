//
//  ConverterTests.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-03.
//

import XCTest

import XCTest
@testable import TestingSwift

class ConverterTests: XCTestCase {
    
    var sut: Converter!

    override func setUpWithError() throws {
        sut = Converter()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test100FahrenheitIs37Celsius() {
        // Given
        let input = 100.0
        
        // When
        let celsius = sut.convertToCelsius(fahrenheit: input)
        
        // Then
        XCTAssertEqual(celsius, 37.777777, accuracy: 0.000001)
    }
    
    func test32FarenheitIsZeroCelsius() {
        // Given
        let input = 32.0
        
        // When
        let celsius = sut.convertToCelsius(fahrenheit: input)
        
        // Then
        XCTAssertEqual(celsius, 0, accuracy: 0.000001)
    }
    
    func test212FahrenheitIs100Celsius() {
        // Given
        let input = 212.0
        
        // When
        let celsius = sut.convertToCelsius(fahrenheit: input)
        
        // Then
        XCTAssertEqual(celsius, 100, accuracy: 0.000001)
    }
    
    // Legacy
    // This function is broken into smalled versions
    func testFahrenheitToCelsius() {
        // Given
//        let sut = Converter()
//        let input1 = 32.0
//        let input2 = 212.0
        
        // When
//        let output1 = sut.convertToCelsius(fahrenheit: input1)
//        let output2 = sut.convertToCelsius(fahrenheit: input2)

        // Then
//        XCTAssertEqual(output1, 0)
//        XCTAssertEqual(output2, 100)
    }

}
