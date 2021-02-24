//
//  TestingSwiftUserInterfaceTests.swift
//  TestingSwiftUserInterfaceTests
//
//  Created by Daniel Spady on 2021-02-24.
//

import XCTest

class TestingSwiftUserInterfaceTests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLabelCopiesTextField() throws {
        // Given
        app.textFields.element.tap()
        
        // When
        app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        app.keyboards.buttons["Return"].tap()
        
        // Then
        XCTAssertEqual(app.staticTexts["TextCopy"].label, "test")
    }
    
    func testSliderControlsProgress() throws {
        // Given
        app.sliders["50%"].adjust(toNormalizedSliderPosition: 1)
        
        // When
        guard let completion = app.progressIndicators.element.value as? String else {
            XCTFail("Unable to find progress indicators")
            return
        }
        
        // Then
        XCTAssertEqual(completion, "0%")
    }
    
    func testTitleMatchesSegmentControl() throws {
        // When
        app.segmentedControls.buttons["Second"].tap()
        
        // Then
        XCTAssertEqual(app.navigationBars.element.title, "")
    }
    
    func testButtonsPopAlert() throws {
        // When
        app.buttons["Green"].tap()
        
        // Then
        XCTAssertTrue(app.alerts["Green"].exists)
        
        // Clean up
        app.alerts["Green"].buttons["OK"].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
