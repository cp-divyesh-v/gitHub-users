//
//  TableViewController.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 02/07/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var viewModel: TableViewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUser()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.store.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        return cell
    }
}
