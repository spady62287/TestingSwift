//
//  MegaController.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-09.
//

import Foundation
import UIKit

// Where Constructor Injection Fails and Succeeds

class MegaController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, URLSessionDownloadDelegate {
    
    // Using Dependency Injection with this View Controller
    // Example of a Massive View Controller
    // Would require massive Test Doubles
    // Example of Bad Code
    // View Controllers should be small and composable
    var tableDataSource: UITableViewDataSource
    weak var tableDelegate: UITableViewDelegate?
    var pickerDataSource: UIPickerViewDataSource
    weak var pickerDelegate: UIPickerViewDelegate?
    weak var downloadDelegate: URLSessionDownloadDelegate?
    
    init(tableDataSource: UITableViewDataSource, tableDelegate: UITableViewDelegate, pickerDataSource: UIPickerViewDataSource, pickerDelegate: UIPickerViewDelegate, downloadDelegate: URLSessionDownloadDelegate) {
        self.tableDataSource = tableDataSource
        self.tableDelegate = tableDelegate
        self.pickerDataSource = pickerDataSource
        self.pickerDelegate = pickerDelegate
        self.downloadDelegate = downloadDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    var cookies = ["Sugar", "Chocolate Chip", "Oatmeal", "Raisins", "Plain"]
    let cellReuseIdentifier = "cell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cookies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!

        cell.textLabel?.text = cookies[indexPath.row]

        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return cookies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cookies.count
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
}
