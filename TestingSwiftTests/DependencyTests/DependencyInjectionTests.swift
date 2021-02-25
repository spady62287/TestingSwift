//
//  DependencyInjectionTests.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-10.
//

import XCTest
@testable import TestingSwift

class DependencyInjectionTests: XCTestCase {
    
    // Integration Tests
    func testShareViewControllerDisplayStoredMessage() {
        // Given
        let shareViewController = ShareViewController()
        
        // When
        shareViewController.loadView()
        let shareView: ShareView = shareViewController.view as! ShareView
        shareView.textField.text = "Message in TextField"
        // Simulate Button Tap
        shareView.shareTapped()
        let storedMessage = shareViewController.displayStoredMessage()
        
        // Then
        XCTAssertEqual(storedMessage, "Message in TextField")
    }
    
    func testAppUrlCount() {
        // Given
        var urlHandler = URLHandler()
        
        // When
        let absoluteStringUrl = URL(string: "internal://ApplicationHomePage")!
        urlHandler.open(url: absoluteStringUrl)
        
        // Then
        XCTAssertTrue(urlHandler.appUrls.count == 1)
    }
    
    func testUIApplicationUrlCount() {
        // Given
        var urlHandler = URLHandler()
        
        // When
        urlHandler.open(url: URL(fileURLWithPath: "www.google.com"))
        
        // Then
        XCTAssertTrue(urlHandler.uiApplicationUrls.count == 1)
    }
    
}
