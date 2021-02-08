//
//  PurchaseProtocol.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-08.
//

import Foundation

// Designing to interfaces rather than implementations

// Use protocols instead of concrete types

// Define what the User and Apps should look like
protocol UserProtocol {
    var funds: Decimal { get set }
    var age: Int { get set }
    var apps: [AppProtocol] { get set }
}

protocol AppProtocol {
    var price: Decimal { get set }
    var minimumAge: Int { get set }
    var isReleased: Bool { get set }
    
    func canBePurchased(by user: UserProtocol) -> Bool
    static func printTerms() -> String
}

// Make User and App conform to the above protocols

struct UserInterfaceExample: UserProtocol {
    
    var funds: Decimal
    var age: Int
    var apps: [AppProtocol]
    
    mutating func buy(_ app: AppProtocol) -> Bool {
        
        let possible = app.canBePurchased(by: self)
        
        if possible {
            apps.append(app)
            funds -= app.price
            return true
        } else {
            return false
        }
    }
}

struct AppInterfaceExample: AppProtocol {
    
    var price: Decimal
    var minimumAge: Int
    var isReleased: Bool
    
    func canBePurchased(by user: UserProtocol) -> Bool {
        
        guard isReleased else {
            return false
        }
        
        guard user.funds >= price else {
            return false
        }
        
        if user.age >= minimumAge {
            return true
        } else {
            return false
        }
    }
}

// When working with protocols, you might sometimes need to call a static method rather than an instance method.
extension AppProtocol {
    static func printTerms() -> String {
        return "Here are 50 pages of terms and conditions for you to read on a tiny phone screen"
    }
}

// User struct can work with anything that conforms to AppProtocol, and our App struct can work with anything that conforms to UserProtocol

// Note: There is a Performance cost to using protocols
