//
//  TableViewCell.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 12/07/21.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewCell: UITableViewCell {
    static var NIB: UINib { UINib(nibName: String(describing: Self.self), bundle: .main) }
    static var ID: String { String(describing: Self.self) }
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    @IBOutlet weak var nameLabel: UILabel!
     
    var cellModel: CellModel? {
        didSet {
            guard let cellModel = self.cellModel else {
                return
            }
            cellModel.name.asObserver().bind { name in
                self.nameLabel.text = name
            } .disposed(by: self.disposeBag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
