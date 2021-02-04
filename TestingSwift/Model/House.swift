//
//  House.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-04.
//

import Foundation

struct House {
    var bedrooms: Int
    var bathrooms: Int
    var cost: Int
    
    init(bedrooms: Int, bathrooms: Int) {
        self.bedrooms = bedrooms
        self.bathrooms = bathrooms
        self.cost = bedrooms * bathrooms * 50_000
    }
    
    func checkSuitabillity(desiredBedrooms: Int, desiredBathrooms: Int) -> Bool {
        if bedrooms >= desiredBedrooms && bathrooms >= desiredBedrooms {
            if bedrooms >= desiredBedrooms && bathrooms >= desiredBedrooms {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
