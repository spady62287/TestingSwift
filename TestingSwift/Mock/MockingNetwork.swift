//
//  MockingNetwork.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-15.
//

import Foundation

// Networking is where mocking really comes into its own, because it allows us to run simulated network requests

class News {
    var url: URL
    var stories = ""
    
    init(url: URL) {
        self.url = url
    }
    
    // Testing the below class requires we remove the dependency of URLSession.shared

    func fetchWithURLSessionDependency(completionHandler: @escaping () -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                self.stories = String(decoding: data, as: UTF8.self)
            }
            
            completionHandler()
            
        }
        
        task.resume()
    }
    
    // Inject URLSession Dependency
    
    func fetchWithDependencyInjection(using session: URLSession = .shared, completionHandler: @escaping () -> Void) {
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let data = data {
                self.stories = String(decoding: data, as: UTF8.self)
            }
            
            completionHandler()
            
        }
        
        task.resume()
    }
    
    // Inject URLSession Protocol
    
    func fetch(using session: URLSessionProtocol = URLSession.shared, completionHandler: @escaping () -> Void ) {
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                self.stories = String(decoding: data, as: UTF8.self)
            }
            
            completionHandler()
        }
        
        completionHandler()
        
        task.resume()
    }
    
}

// Create a protocol that lets us mock URLSession

// Needs us to call dataTask(with:), passing in a completion handler

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
