//
//  ProfileCell.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 23/07/21.
//

import UIKit
import RxSwift

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    var cellModel: ProfileCellModel? {
        didSet {
            guard let cellModel = self.cellModel else {
                return
            }
            cellModel.avatar.asObserver().bind { avatar in
                self.profileImageView.image = avatar
            } .disposed(by: self.disposeBag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
