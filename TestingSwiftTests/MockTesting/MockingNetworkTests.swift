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
        
        var completionHandler: (Data?, URLResponse?, Error?) -> Void
        
        init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
            self.completionHandler = completionHandler
        }
        
        override func resume() { }
    }
    
    // Use defer so that it automatically calls its completion handler with nil values
    
    class URLSessionMock: URLSessionProtocol {
        
        var lastUrl: URL?
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            // mocked networking code will be "completed" before we've even called resume()
            defer { completionHandler(nil, nil, nil) }
            lastUrl = url
            return DataTaskMock(completionHandler: completionHandler)
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
        wait(for: [expectation], timeout: 5)
    }
    
    // 2. Was a network request actually started?
    
    // Use this Mock to track when resume was called
    
    class DataTaskMockTwo: URLSessionDataTask {
        
        var completionHandler: (Data?, URLResponse?, Error?) -> Void
        var resumeWasCalled = false
        
        init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
            self.completionHandler = completionHandler
        }
        
        override func resume() {
            // resume was called, so flip boolean and call the completion
            resumeWasCalled = true
            completionHandler(nil, nil, nil)
        }
    }
    
    // Return new Mocked DataTask
    
    class URLSessionMockTwo: URLSessionProtocol {
        
        var dataTask: DataTaskMockTwo?
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            let newDataTask = DataTaskMockTwo(completionHandler: completionHandler)
            dataTask = newDataTask
            return newDataTask
        }
    }
    
    func testNewsFetchCallsResume() {
        
        // Given
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url)
        let session = URLSessionMockTwo()
        let expectation = XCTestExpectation(description: "Downloading news stories triggers resume().")
        
        // When
        news.fetch(using: session) {
            XCTAssertTrue(session.dataTask?.resumeWasCalled ?? false)
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
    }
    
    // 3. Did the requestcome back with certain data?
    
    // Customizable stub
    
    // Defer to call completion handler with pre-set data
    
    // DataTaskMock is a Dummy Mock
    
    class URLSessionMockThree: URLSessionProtocol {
        
        var testData: Data?
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            defer {
                completionHandler(testData, nil, nil)
            }
            
            return DataTaskMock(completionHandler: completionHandler)
        }
    }
        
    func testNewsStoriesAreFetched() {
        
        // Given
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url)
        let session = URLSessionMockThree()
        session.testData = Data("Hello, world!".utf8)
        let expectation = XCTestExpectation(description: "Downloading news stories triggers resume().")
        
        // When
        news.fetch(using: session) {
            XCTAssertEqual(news.stories, "Hello, world!")
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
    }
        
    // 4. Did the request come back with a specific error
    
    
}
