//
//  DependencyInjectionTests.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-10.
//

import XCTest
@testable import TestingSwift

class DependencyInjectionTests: XCTestCase {
    
    func testShareViewControllerDisplayStoredMessage() {
        // Given
        let shareViewController = ShareViewController()
        
        // When
        shareViewController.loadView()
        let shareView = shareViewController.view as! ShareView
        shareView.textField.text = "Message in TextField"
        // Simulate Button Tap
        shareView.shareTapped()
        let storedMessage = shareViewController.displayStoredMessage()
        
        // Then
        XCTAssertEqual(storedMessage, "Message in TextField")
    }
    
}
