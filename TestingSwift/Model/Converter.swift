//
//  Converter.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-03.
//

import Foundation

struct Converter {
    func convertToCelsius(fahrenheit: Double) -> Double {
        let fahrenheit = Measurement(value: fahrenheit, unit: UnitTemperature.fahrenheit)
        let celsius = fahrenheit.converted(to: .celsius)
        return celsius.value
        // return (fahrenheit - 32) * 5 / 9
    }
    
    // Method that returns a tuple
    func divisionRemainder(of number: Int, dividedBy: Int) -> (quotient: Int, remainder: Int) {
        let quotient = number / dividedBy
        let remainder = number % dividedBy
        return (quotient, remainder)
    }
}
