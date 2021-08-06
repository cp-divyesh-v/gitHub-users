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
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellBg: UIView!
    
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
        decorateCell()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func decorateCell() {
        cellBg.layer.cornerRadius = frame.height/4
    }
}
