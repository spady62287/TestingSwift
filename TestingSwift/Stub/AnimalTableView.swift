//
//  TableViewDataSourceStub.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-08.
//

import Foundation
import UIKit

class AnimalTableView: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var animalTableView = UITableView()
    var animals = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    let cellReuseIdentifier = "cell"

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!

        cell.textLabel?.text = animals[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
