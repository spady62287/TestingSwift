//
//  User.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-03.
//

import Foundation

struct User {
    // Notification that signals User has been upgraded
    static let upgradeNotification = Notification.Name("UserUpgraded")
    
    // Upgrade user function
    func upgrade() {
        
        // Open a backbround thread
        DispatchQueue.global().async {
            
            // Pause thread
            Thread.sleep(forTimeInterval: 1)
            
            // Create and Post a Notifaction
            let center = NotificationCenter.default
            center.post(name: User.upgradeNotification, object: nil)
        }
    }
    
    // Return a Random Age for User
    func randomAge() -> Int {
        // Range the age
        return Int.random(in: 0...120)
    }
}

struct MultiLevelUser {
    // Notification for a Multi Level User
    static let upgradeNotification = Notification.Name("MultiLevelUserUpgraded")
    
    // function to upgrade User to Gold level
    func upgradeUserGold() {
        
        // Open a background thread
        DispatchQueue.global().async {
            
            // Pause thread for 1 second
            Thread.sleep(forTimeInterval: 1)
            
            // Create and Post a Notification
            let center = NotificationCenter.default
            center.post(name: MultiLevelUser.upgradeNotification, object: nil, userInfo: ["level": "gold"])
        }
    }
}
