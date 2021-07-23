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
        setUpRxObserver()
        iniyView()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! TableViewCell
        cell.cellModel = items[indexPath.row]
        return cell
    }
    func iniyView() {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "nameCell")
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
