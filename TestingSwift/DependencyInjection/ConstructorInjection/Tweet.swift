//
//  Tweet.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-09.
//

import Foundation

// Constructor Injection in Practice

// This object is initialized with a text and author
// The Date is created automatically

// However we are unable to test specific dates
struct TweetCurrentDateDefault {
    
    var text: String
    var author: String
    var date: Date
    
    init(text: String, author: String) {
        self.text = text
        self.author = author
        self.date = Date()
    }
}

// Constructor that Initializes a Tweet with text, author, and date
struct TweetInitializer {
    
    var text: String
    var author: String
    var date: Date
    
    init(text: String, author: String, date: Date) {
        self.text = text
        self.author = author
        self.date = date
    }
}

// Remove the initializer
// Changed the API, now all values need to be provided

struct TweetConstruct {
    
    var text: String
    var author: String
    var date: Date
    
}

// Initializes a Tweet with text, author, and date
// Current Date is injected into the Constructor
// values can be changed after initialization
struct TweetDynamic {
    
    var text: String
    var author: String
    var date: Date
    
    init(text: String, author: String, date: Date = Date()) {
        self.text = text
        self.author = author
        self.date = date
    }
    
}

// Initializes a tweet with text, author, and date
// Current Date is injected into the Constructor
// Values are not mutable as let constants
struct TweetConstant {
    
    let text: String
    let author: String
    let date: Date
    
    init(text: String, author: String, date: Date = Date()) {
        self.text = text
        self.author = author
        self.date = date
    }
}
