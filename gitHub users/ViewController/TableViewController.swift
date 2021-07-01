//
//  TableViewController.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 01/07/21.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    

    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func setUpText() {
        userNameLabel.text = "this is going to set"
    }
}

