//
//  PartialMock.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-12.
//

import Foundation
import UIKit

// Create a struct that holds the static strings that display when the Status is called

struct BatteryState {
    static let powerDown = "Power is down"
    static let powerError = "Error"
    static let powerUp = "Power is up"
}

// Create a explicit dependency as a property for the status method

struct PowerMonitor {
    
    var device: UIDevice
    
    func getStatus() -> String {
        
        if device.batteryState == .unplugged {
            return BatteryState.powerDown
        } else if device.batteryState == .unknown {
            return BatteryState.powerError
        } else {
            return BatteryState.powerUp
        }
    }
}
