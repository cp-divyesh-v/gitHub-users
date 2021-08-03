//
//  UIViewViewController.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 23/07/21.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var disposeBag: DisposeBag = DisposeBag()
    
    var viewModel: DetailViewModel!
    var avatarCell = [ProfileCellModel]()
    var repoItems = [CellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setUpRxObserver()
        initView()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func initView() {
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "nameCell")
        viewModel.fetchImage(from: viewModel.user.avatarURL)
    }

}

extension DetailViewController: UITableViewDelegate {

    
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repoItems.count + avatarCell.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ProfileCell
            cell.cellModel = avatarCell[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! TableViewCell
            cell.cellModel = repoItems[indexPath.row]
            return cell
        }
    }
    
    func setUpRxObserver() {
        setUpContantChangeObserver()
    }
    
    func setUpContantChangeObserver() {
        viewModel.profileCell.asObservable().subscribe(onNext: { cell in
            self.avatarCell = cell
            self.tableView.reloadData()
        }) .disposed(by: disposeBag)
        
        viewModel.repos.asObservable().subscribe(onNext: { repos in
            self.repoItems = repos
            self.tableView.reloadData()
        }) .disposed(by: disposeBag)
    }
    
}
