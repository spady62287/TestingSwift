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
    
    func testUserCantBuyUnrealeasedApp() {
        // Given
        // User Struct
        var sut = UserInterfaceExample(funds: 100, age: 21, apps: [])
                
        // Need a Test Double
        // Creating a Stub to test the canBePurchased method returns False
        struct UnreleasedAppStub: AppProtocol {
            
            var price: Decimal = 0
            var minimumAge: Int = 0
            var isReleased: Bool = false
            
            func canBePurchased(by user: UserProtocol) -> Bool {
                return false
            }
        }
        
        // Stub Object:
        let app = UnreleasedAppStub()
        
        // When
        let wasBought = sut.buy(app)
        
        // Then
        XCTAssertFalse(wasBought)
    }
    
    func testUserPrintTermsStaticMethod() {
        // Given
        // App Struct
        let sut = AppInterfaceExample(price: 100, minimumAge: 21, isReleased: false)
        
        // Need a Test Double
        // Creating a Stub to test the printTerms method
        struct StaticMethodTest {
            
            static func printTerms() -> String {
                return "Here are 50 pages of terms and conditions for you to read on a tiny phone screen"
            }
        }
        
        // When
        let terms = type(of: sut).printTerms()
        
        // Then
        XCTAssertEqual(terms, StaticMethodTest.printTerms())
    }
    
}
