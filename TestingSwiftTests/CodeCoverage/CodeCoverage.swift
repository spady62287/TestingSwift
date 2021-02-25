//
//  CodeCoverage.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-04.
//

import XCTest
@testable import TestingSwift

class CodeCoverage: XCTestCase {
    
    func test4Bed2BathHouse_Fits3Bed2BathRequirements() {
        
        // Given
        let house = House(bedrooms: 4, bathrooms: 2)
        let desiredBedrooms = 3
        let desiredBathrooms = 2
        
        // When
        let suitability = house.checkSuitabillity(desiredBedrooms: desiredBedrooms, desiredBathrooms: desiredBathrooms)
        
        // Then
        // XCTAssertTrue(suitability)
        XCTAssertFalse(suitability)
    }
    
}
