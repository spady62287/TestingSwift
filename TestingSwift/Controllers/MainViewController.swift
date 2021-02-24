//
//  MainViewController.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-24.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
        
    @IBAction func textChanged(_ sender: UITextField) {
        label.text = textField.text
    }
    
    @IBAction func sliderDragged(_ sender: UISlider) {
        progress.progress = 1 - slider.value
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        title = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex)
    }
    
    @IBAction func colorSelected(_ sender: UIButton) {
        let alert = UIAlertController(title: sender.titleLabel?.text, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
