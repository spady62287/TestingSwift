//
//  URLOpener.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-10.
//

import Foundation
import UIKit

// Struct with a Static string to check for Prefix
struct UrlPrefix {
    static let internalColon = "internal://"
}

// URL Handler that opens a url based on the prefix of the absolute string
struct URLHandlerUIApplicationDependency {
    
    func open(url: URL) {
        if url.absoluteString.hasPrefix(UrlPrefix.internalColon) {
            // run some app-specific code
        } else {
            // Adds a dependency to this struct with UIApplication
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

// Wrap UIApplication in a protocol that gets injected to remove the dependency
protocol ApplicationProtocol {
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)? )
}

// Make UIApplication conform to the above protocol
// Does not require a new method because there is already a "open" method
extension UIApplication: ApplicationProtocol { }

// Make "URLHandler" store an instance of a variable that conforms to "ApplicationProtocol"
// Use that to call URL opener
struct URLHandlerPropertyProtocol {
    let application: ApplicationProtocol
    
    func open(url: URL) {
        if url.absoluteString.hasPrefix(UrlPrefix.internalColon) {
            // run some app-specific code
        } else {
            application.open(url, options: [:], completionHandler: nil)
        }
    }
}

// Create some sort of Test Double that also conforms to ApplicationProtocol so that we can test it

// Use Closure Injection

// Rather than creating an ApplicationProtocol protocol, making UIApplication conform to it, building a test double and making that conform to it, then adding an ApplicationProtocol property to our type

// Create a typealias for longer signatures
typealias URLOpening = (URL, [UIApplication.OpenExternalURLOptionsKey: Any], ((Bool) -> Void)? ) -> Void

// Make URLHandler have a single property specifying what code should be run to open external URLs:
struct URLHandler {
    
    // Provide Default value
    let urlOpener: URLOpening = UIApplication.shared.open
    var appUrls: [URL] = []
    var uiApplicationUrls: [URL] = []
    
    mutating func open(url: URL) {
        if url.absoluteString.hasPrefix(UrlPrefix.internalColon) {
            appUrls.append(url)
            // run some app-specific code
        } else {
            uiApplicationUrls.append(url)
            urlOpener(url, [:], nil)
        }
    }
}
