//
//  ProfileCellModel.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 28/07/21.
//

import Foundation
import UIKit
import RxSwift

class ProfileCellModel {
    
    let avatar: BehaviorSubject<UIImage>
    
    init(avatar: UIImage) {
        self.avatar = .init(value: avatar)
    }
}
