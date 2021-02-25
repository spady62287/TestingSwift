//
//  Game.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-03.
//

import Foundation

struct GameConfirmMessage {
    static let play = "is OK to play!"
}

enum GameTitles: String {
    case bioBlitz
    case blastaap
    case deadStormRising = "Dead Storm Rising"
    case explodingAnimals = "Exploding Animals"
    case crashyPlane = "Crashy Plane"
}

enum GameError: LocalizedError {
    case notPurchased
    case notInstalled
    case parentalControlsDisallowed
}

struct Game {
    let name: String
    
    func play() throws {
        if name == GameTitles.bioBlitz.rawValue {
            throw GameError.notPurchased
        } else if name == GameTitles.blastaap.rawValue {
            throw GameError.notInstalled
        } else if name == GameTitles.deadStormRising.rawValue {
            throw GameError.parentalControlsDisallowed
        } else {
            print("\(name) \(GameConfirmMessage.play)")
        }
    }
}

extension LocalizedError {
    var errorDescription: String? {
        return "\(self)"
    }
}
