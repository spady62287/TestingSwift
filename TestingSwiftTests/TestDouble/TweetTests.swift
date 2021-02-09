//
//  TweetTests.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-09.
//

import XCTest
@testable import TestingSwift

class TweetTests: XCTestCase {
    
    func testTweetCurrentDateFalse() {
        // Given
        let tweetMessage = "This Tweet is going to post"
        let tweetAuthor = "Username"
        
        // Current Date Tweet
        let currentDateTweet = TweetCurrentDateDefault(text: tweetMessage, author: tweetAuthor)
        
        // Test Double
        // Create a Tweet Test Stub
        struct TweetCurrentDateStub {
            var text: String = "This Tweet is going to post"
            var author: String = "Username"
            var date: Date = Date()
        }
        
        // When
        // Tweet Created at different Date is false
        let testDouble = TweetCurrentDateStub()
        
        // Then
        XCTAssertFalse(testDouble.date == currentDateTweet.date)
    }
    
    func testTweetCurrentDateTrue() {
        // Given
        let tweetMessage = "This Tweet is going to post"
        let tweetAuthor = "Username"
        let currentDate = Date()
        
        // Tweet Initializer
        let currentDateTweet = TweetInitializer(text: tweetMessage, author: tweetAuthor, date: currentDate)
        
        // Test Double
        // Create a Tweet Test Stub
        struct TweetCurrentDateStub {
            var text: String = "This Tweet is going to post"
            var author: String = "Username"
            var date: Date
        }
        
        // When
        // Test Double is created with Date
        let tweetStub = TweetCurrentDateStub(date: currentDate)
        
        // Then
        XCTAssertTrue(currentDateTweet.date == tweetStub.date)
    }
    
    func testTweetConstructorAuthor() {
        // Given
        let tweetMessage = "This Tweet is going to post"
        let tweetAuthor = "Username"
        let currentDate = Date()
        
        // Tweet Construct
        let currentDateTweet = TweetConstruct(text: tweetMessage, author: tweetAuthor, date: currentDate)
        
        // Test Double
        struct TweetCurrentDateStub {
            var text: String = "This Tweet is going to post"
            var author: String = "Username"
            var date: Date
        }
        
        // When
        // Test Double is created with Date
        let tweetStub = TweetCurrentDateStub(date: currentDate)
        
        // Then
        XCTAssertEqual(currentDateTweet.author, tweetStub.author)
    }
    
    func testTweetConstructorText() {
        // Given
        let tweetMessage = "This Tweet is going to post"
        let tweetAuthor = "Username"
        let currentDate = Date()
        
        // Tweet Construct
        let currentDateTweet = TweetConstruct(text: tweetMessage, author: tweetAuthor, date: currentDate)
        
        // Test Double
        struct TweetCurrentDateStub {
            var text: String = "This Tweet is going to post"
            var author: String = "Username"
            var date: Date
        }
        
        // When
        // Test Double is created with Date
        let tweetStub = TweetCurrentDateStub(date: currentDate)
        
        // Then
        XCTAssertEqual(currentDateTweet.text, tweetStub.text)
    }
}
