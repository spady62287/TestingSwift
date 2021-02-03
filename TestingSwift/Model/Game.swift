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
    case BioBlitz
    case Blastaap
    case DeadStormRising = "Dead Storm Rising"
    case ExplodingAnimals = "Exploding Animals"
    case CrashyPlane = "Crashy Plane"
}

enum GameError: LocalizedError {
    case notPurchased
    case notInstalled
    case parentalControlsDisallowed
}

struct Game {
    let name: String
    
    func play() throws {
        if name == GameTitles.BioBlitz.rawValue {
            throw GameError.notPurchased
        } else if name == GameTitles.Blastaap.rawValue {
            throw GameError.notInstalled
        } else if name == GameTitles.DeadStormRising.rawValue {
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
