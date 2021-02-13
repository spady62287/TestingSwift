//
//  PartialMock.swift
//  TestingSwiftTests
//
//  Created by Daniel Spady on 2021-02-12.
//

import XCTest
@testable import TestingSwift

class PartialMock: XCTestCase {
        
    // To be able to test all conditions inside getStatus() we need to be able to send in all three battery states that are checked: .unplugged, .unknown, and everything else.
    
    // Use mock and partial mocks
    
    // Partial mock is when you subclass a type and override only the parts you want to control.
    
    // Note: Subclassing only works with classes and not structs.
    
    func testUnpluggedDeviceShowsDown() {
        
        // Partial Mock
        
        class UnpluggedDeviceMock: UIDevice {
            override var batteryState: UIDevice.BatteryState {
                return .unplugged
            }
        }
                
        // Given
        let sut = PowerMonitor(device: UnpluggedDeviceMock())
        
        // When
        let message = sut.getStatus()
        
        // Then
        XCTAssertEqual(message, BatteryState.powerDown)
    }
    
    func testUnknownDeviceShowsUnknown() {
        
        // Partial Mock
        
        class UnknownDeviceMock: UIDevice {
            override var batteryState: UIDevice.BatteryState {
                return .unknown
            }
        }
        
        // Given
        let sut = PowerMonitor(device: UnknownDeviceMock())
        
        // When
        let message = sut.getStatus()
        
        // Then
        XCTAssertEqual(message, BatteryState.powerError)
        
    }
    
    func testChargingDeviceShowsCharging() {
        
        // Partial Mock
        
        class ChargingDeviceMock: UIDevice {
            override var batteryState: UIDevice.BatteryState {
                return .charging
            }
        }
        
        // Given
        let sut = PowerMonitor(device: ChargingDeviceMock())
        
        // When
        let message = sut.getStatus()
        
        // Then
        XCTAssertEqual(message, BatteryState.powerUp)
    }
    
    // Instead of creating 3 Partial mocks with specific states
    // A better solution is to make one subclass and tell it what behavior we expect:
    
    class DeviceMock: UIDevice {
        
        var testBatteryState: BatteryState
        
        init(testBatteryState: BatteryState) {
            self.testBatteryState = testBatteryState
            super.init()
        }
        
        override var batteryState: UIDevice.BatteryState {
            return testBatteryState
        }
    }
    
    func testUnpluggedDeviceShowsDownMockSubclass() {
        // Given
        let sut = PowerMonitor(device: DeviceMock(testBatteryState: .unplugged))
        
        // When
        let message = sut.getStatus()
        
        // Then
        XCTAssertEqual(message, BatteryState.powerDown)
    }
    
    func testUnknownDeviceShowsUnknownMockSubclass() {
        // Given
        let sut = PowerMonitor(device: DeviceMock(testBatteryState: .unknown))
        
        // When
        let message = sut.getStatus()
        
        // Then
        XCTAssertEqual(message, BatteryState.powerError)
    }

    func testChargingDeviceShowsChargingMockSubclass() {
        // Given
        let sut = PowerMonitor(device: DeviceMock(testBatteryState: .charging))
        
        // When
        let message = sut.getStatus()
        
        // Then
        XCTAssertEqual(message, BatteryState.powerUp)
    }
    
    // A Full Mock is where we wrap UIDevice in a protocol, then send in a complete replacement that conforms to the same protocol.
    
    func testFullMockUnpluggedBatteryPower() {
        
        // Add a mock type that implements the same protocol

        struct DeviceMock: DeviceProtocol {
            
            var testBatteryState: UIDevice.BatteryState
            
            var batteryState: UIDevice.BatteryState {
                return testBatteryState
            }
        }
        
        // Given
        let sut = PowerMonitorProto(device: DeviceMock(testBatteryState: .unplugged))
        
        // When
        let message = sut.getStatus()
        
        // Then
        XCTAssertEqual(message, BatteryState.powerDown)
    }
    
    func testFullMockUnknownBatteryPower() {
        // Add a mock type that implements the same protocol

        struct DeviceMock: DeviceProtocol {
            
            var testBatteryState: UIDevice.BatteryState
            
            var batteryState: UIDevice.BatteryState {
                return testBatteryState
            }
        }
        
        // Given
        let sut = PowerMonitorProto(device: DeviceMock(testBatteryState: .unknown))
        
        // When
        let message = sut.getStatus()
        
        // Then
        XCTAssertEqual(message, BatteryState.powerError)
    }
    
    func testFullMockChargingBatteryPower() {
        
        // Add a mock type that implements the same protocol

        struct DeviceMock: DeviceProtocol {
            
            var testBatteryState: UIDevice.BatteryState
            
            var batteryState: UIDevice.BatteryState {
                return testBatteryState
            }
        }
        
        // Given
        let sut = PowerMonitorProto(device: DeviceMock(testBatteryState: .charging))
        
        // When
        let message = sut.getStatus()
        
        // Then
        XCTAssertEqual(message, BatteryState.powerUp)
    }
}
