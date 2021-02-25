//
//  Player.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-03.
//

import Foundation

struct Player: Equatable {
    let nation: String
    var cities: [String] = ["USA"]
    var enemies: [Player] = []
    
    mutating func buildCity(name: String) {
        cities.append(name)
    }
    
    mutating func declareWar(target: Player) {
        enemies.append(target)
    }
}

// Takes a copy of the original array, then loops over the other array removing each item it finds until there are none left. If any are missing it returns false, but if it's going through all items successfully it returns true.
extension Array where Element: Equatable {
    func fuzzyMatches(other: Array) -> Bool {
        guard self.count == other.count else {
            return false
        }
        
        var selfCopy = self
        
        for item in other {
            if let index = selfCopy.firstIndex(of: item) {
                selfCopy.remove(at: index)
            } else {
                return false
            }
        }
        
        return true
    }
}
