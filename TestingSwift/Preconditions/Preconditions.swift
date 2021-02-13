//
//  Preconditions.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-13.
//

import Foundation

// Dealing with functions that would otherwise be fatal, such as precondition() or assert().

// fatalError() should not be reached

// User class to store user details

class UserPrecondition { }

// Store class that is responsible for letting users buy products

class StorePrecondition {
    
    var user: UserPrecondition?
    
    // Add our own instance method called assert() that matches Swift's own assert(), calling straight through to Swift's version in production code but silently acting as a flight recorder while testing
    
    func assert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) {
        Swift.assert(condition(), message(), file: file, line: line)
    }
    
    // Check whether we have a valid user set, and use assert()
    
    func buy(product: String) -> Bool {
        
        // Programmer error for this method to be called without a user
        
        assert(user != nil, "We can't buy anything without a user.")
        
        print("The user bought \(product).")
        return true
    }
}
