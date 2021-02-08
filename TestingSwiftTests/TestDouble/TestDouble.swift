//
//  TestDouble.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-08.
//

import XCTest
@testable import TestingSwift

class TestDouble: XCTestCase {
    
    var sut: AnimalTableView!

    override func setUpWithError() throws {
        sut = AnimalTableView()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testAnimalTableView() {
        // Given
        let animalCount = sut.animals.count
        let indexPath = IndexPath.init(index: IndexPath.Element(0))
        
        // When
        sut.tableView(sut.animalTableView, didSelectRowAt: indexPath)
        
        // Then
        XCTAssertEqual(sut.animals.count, animalCount)
    }
    
}
