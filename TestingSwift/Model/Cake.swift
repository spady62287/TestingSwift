//
//  Cake.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-07.
//

import Foundation

struct Cake {
    func bake(ingredients: [String]) -> Int {
        for ingredient in ingredients {
            print("Adding \(ingredient).")
        }
        
        let cost = 1 + (ingredients.count * 3)
        print("The cake is ready; please pay \(cost).")
        
        return cost
    }
}
