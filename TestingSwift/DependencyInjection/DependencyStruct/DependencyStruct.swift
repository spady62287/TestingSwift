//
//  DependencyStruct.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-12.
//

import Foundation

protocol EnviromentProtocol {
    var endpoint: String { get set }
}

struct EndPoints {
    static let devEndpoint = "dev://api/v1"
    static let stageEndpoint = "stage://api/v1"
    static let prodEndpoint = "prod://api/v1"
}

struct Dev: EnviromentProtocol {
    var endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
}

struct Staging: EnviromentProtocol {
    var endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
}

struct Production: EnviromentProtocol {
    var endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
}

// Singletons create hidden dependencies because they allow our objects to read state that wasn't explicitly passed in.

// Dependency struct approach works around this by having us create one set of singletons when the app launches, and passing that from place to place

// Singletons are objects that are created once and only once inside an app, but that doesn't stop different runs of the app changing its singleton implementations as seen here

struct Enviroment {
    var devSingleton: Dev
    var stageSingleton: Staging
    var prodSingleton: Production
}
