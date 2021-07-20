//
//  CellModel.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 09/07/21.
//

import Foundation
import RxSwift

class CellModel {
    
    let name: BehaviorSubject<String>
    
    init(name: String) {
        self.name = .init(value: name)
    }
}
