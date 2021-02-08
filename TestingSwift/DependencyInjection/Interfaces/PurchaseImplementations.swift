//
//  PurchaseInterface.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-08.
//

import Foundation

struct AppPurchase {
    
    var price: Decimal
    var minimumAge: Int
    var isReleased: Bool
    
    func canBePurchased(by user: UserPurchase) -> Bool {
        
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

struct UserPurchase {
    
    var funds: Decimal
    var age: Int
    var apps: [AppPurchase]
    
    mutating func buy(_ app: AppPurchase) -> Bool {
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
