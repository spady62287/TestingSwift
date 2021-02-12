//
//  Mocking.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-12.
//

import Foundation

// This class introduces the Home dependency, very difficult to Unit Test. Would require passing a Mock into the function

class Buyer {
    func view(_ home: Home) {
        home.conductingViewing()
    }
}

// Unit test the below method by asserting Equal when the below method is called

class Home {
    var numberOfViewings = 0
    
    func conductingViewing() {
        numberOfViewings += 1
    }
}

// Testing Buyer is trickier: We want to be able to test that viewing a Home correctly adds 1 to the viewing count, but we don't want the internal implementation of Home to get in the way.

// The solution here is to create a protocol that Home conforms to so that we can put a test double in its place.

protocol HomeProtocol {
    var numberOfViewings: Int { get set }
    func conductViewing()
}

class HomeProtoExample: HomeProtocol {
    
    var numberOfViewings = 0
    
    func conductViewing() {
        numberOfViewings += 1
    }
}

// Update the Buyer class to use the Home Protocol instead of the implementation

class BuyerProtoExample {
    
    func view(_ home: HomeProtocol) {
        home.conductViewing()
    }
}

// The behavior of the Home class can change over time

// Unit test the below class with Mock
protocol HomeProtocolTwo {
    func conductingViewing()
}

class HomeProtoExampleTwo: HomeProtocolTwo {
    func conductingViewing() {
        print("The buyer looked at the house")
    }
}

// Update the Buyer class to use new Protocol

class BuyerProtoExampleTwo {
    func view(_ home: HomeProtocolTwo) {
        home.conductingViewing()
    }
}
