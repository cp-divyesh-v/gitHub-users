//
//  TableViewController.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 02/07/21.
//

import UIKit
import RxSwift

class TableViewController: UITableViewController {
    
    lazy var disposeBag: DisposeBag = DisposeBag()
    var viewModel = TableViewViewModel()
    var items = [CellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        setUpRxObserver()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.ID, for: indexPath) as! TableViewCell
        cell.cellModel = items[indexPath.item]
        return cell
    }
    func iniyView() {
        tableView.register(TableViewCell.NIB, forCellReuseIdentifier: TableViewCell.ID)
    }
    func fetchUser() {
        viewModel.getUser()
    }
    
    func setUpRxObserver() {
        setUpContantChangeObserver()
    }
    
    func setUpContantChangeObserver() {
        viewModel.cells.asObservable().subscribe(onNext: { cells in
            self.items = cells
            self.tableView.reloadData()
        }) .disposed(by: disposeBag)
    }
}
