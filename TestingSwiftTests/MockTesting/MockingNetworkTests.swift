//
//  MockingNetworkTests.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-15.
//

import XCTest
@testable import TestingSwift

class MockingNetworkTests: XCTestCase {
    
    // 1. What was the URL that was requested?
    
    // Requires creating a new concrete implementation of the URLSessionProtocol, which will store the URL that was requested.
    
    // When dataTask() method is called we'll stash away the URL
    
    // Send back an empty data task to satisfy the URL, call completion handler immediately
    
    // Foundation doesn't let us use URLSessionDataTask directly, because it's technically an abstract class.
    
    // Create a mock version that just has an empty resume() method
    
    // Dummy Tests: Doesn't do anything except satisfy the need for dataTask() to return something
    
    class DataTaskMock: URLSessionDataTask {
        override func resume() { }
    }
    
    // Use defer so that it automatically calls its completion handler with nil values
    
    class URLSessionMock: URLSessionProtocol {
        
        var lastUrl: URL?
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            lastUrl = url
            return DataTaskMock()
        }
    }
    
    func testNewsFetchLoadsCorrectURL() {
        
        // Given
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url)
        let session = URLSessionMock()
        let expectation = XCTestExpectation(description: "Downloading news stories.")
        
        // When
        news.fetch(using: session) {
            XCTAssertEqual(URL(string: "https://www.apple.com/newsroom/rss-feed.rss"), session.lastUrl)
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 10)
    }
    
    // 2. Was a network request actually started?
    
    // 3. Did the requestcome back with certain data?
    
    // 4. Did the request come back with a specific error
    
    
}
