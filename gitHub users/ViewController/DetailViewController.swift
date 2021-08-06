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
    
    func initView() {
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "nameCell")
        viewModel.fetchImage(from: viewModel.user.avatarURL)
        viewModel.getRepo()
    }
}

extension DetailViewController: UITableViewDelegate {
}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return avatarCell.count
        case 1:
            return repoItems.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ProfileCell
            cell.cellModel = avatarCell[indexPath.row]
            cell.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
            cell.isUserInteractionEnabled = false
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! TableViewCell
            cell.cellModel = repoItems[indexPath.row]
            cell.isUserInteractionEnabled = false
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return view.frame.width
        case 1:
            return 70
        default:
            return 60
        }
    }
    
    func setUpRxObserver() {
        setUpContantChangeObserver()
    }
    
    func setUpContantChangeObserver() {
        viewModel.profileCell.observe(on: MainScheduler.instance).subscribe(onNext: { cell in
            self.avatarCell = cell
            self.tableView.reloadData()
        }) .disposed(by: disposeBag)
        
        viewModel.repos.observe(on: MainScheduler.instance).subscribe(onNext: { repos in
            self.repoItems = repos
            self.tableView.reloadData()
        }) .disposed(by: disposeBag)
    }
}
