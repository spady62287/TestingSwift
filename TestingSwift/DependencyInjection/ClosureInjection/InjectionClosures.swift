//
//  InjectionClosures.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-10.
//

import Foundation
import UIKit

// Closure Injection is an attractive and relatively simple technique for creating loosely coupled code.

// Solving the problem of massive view controllers, one important weapon in our arsenal is the ability to create custom UIView subclasses and use tgem for our view controllers.

// Create a custom UIView subclass that encapsulates all our layout work.

// Creating another problem that needs to be solved with closure injections, to update the view controller

class ShareView: UIView {
    
    // Closure Property
    var shareAction: (String) -> Void
    var textField: UITextField!
    var button: UIButton!
    
    init(shareAction: @escaping (String) -> Void) {
        self.shareAction = shareAction
        super.init(frame: .zero)
        
        self.textField = UITextField()
        textField.sizeToFit()
        
        addSubview(textField)
        
        self.button = UIButton(type: .system)
        button.sizeToFit()
        // Target/Selector Pattern requires @objc
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        
        addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    // Method to call when a button is tapped
    @objc func shareTapped() {
        guard let text = textField.text else {
            return
        }
        
        shareAction(text)
    }
}

class ShareViewControllerRetainCycle: UIViewController {
    
    // Override LoadView to create a ShareView instance
    // Inject a method dependency that will be called on button tap
    override func loadView() {
        view = ShareView(shareAction: shareContent)
    }
    
    func shareContent(text: String) {
        print("Sharing Text...")
    }
}

// Note: ShareViewControllerRetainCycle owns the view that it is showing, and we've now given the view a strong reference to a method in the view Controller. The view now owns the view controllers. The closure Injection has caused a retain cycle

class ShareViewController: UIViewController {
    
    var shareView: ShareView!
    var storedMessage: String!
    
    // Create a closure using weak self and call the method inside the block to avoid a retain cycle
    override func loadView() {
        
        shareView = ShareView { [weak self] in
            self?.shareContent(text: $0)
        }
        
        view = shareView
    }
    
    func shareContent(text: String) {
        self.storedMessage = text
        print("Sharing text... \(text)")
    }
    
    func displayStoredMessage() -> String {
        return self.storedMessage
    }
}
