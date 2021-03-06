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
        initView()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didActionSubject.onNext(.onTap(indexPath))
    }
    
    func initView() {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "nameCell")
    }
    
    func setUpRxObserver() {
        setUpContantChangeObserver()
        setUpViewToPresetObserver()
    }
    
    func setUpContantChangeObserver() {
        viewModel.cells.asObservable().subscribe(onNext: { cells in
            self.items = cells
            self.tableView.reloadData()
        }) .disposed(by: disposeBag)
    }
    
    func setUpViewToPresetObserver() {
        viewModel.shouldPresentSubject.asObservable()
            .subscribe(onNext: { [weak self] viewToPresent in
                guard let self = self else { return }
                switch viewToPresent{
                case .showDetailView(let viewModel):
                    let vc = DetailViewController(nibName: "DetailViewController", bundle: .none)
                    vc.viewModel = viewModel
                    self.show(vc, sender: nil)
                }
                
            }) .disposed(by: disposeBag)
    }
    
}
