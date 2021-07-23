//
//  TableViewViewModel.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 29/06/21.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class TableViewViewModel {
    
    enum action {
        case onTap(IndexPath)
    }
    
    enum viewToPresent {
        case showDetailView
    }
    
    let store = UserDataStore()
    
    let cells: BehaviorRelay<[CellModel]>
    
    init() {
        cells = .init(value: [])
        getUser()
    }
    
}

extension TableViewViewModel {
    
    func getUser() {
        UserService.fetchUsers { users in
            self.store.users = users
            self.cells.accept(self.prepareCell())
        } errorblock: { error in
            print(error)
        }
    }
    
    func prepareCell() -> [CellModel]{
        let cells = store.users
        return cells.map({CellModel(name: $0.login)})
    }
    
}
