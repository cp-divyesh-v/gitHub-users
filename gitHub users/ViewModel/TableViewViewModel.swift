//
//  TableViewViewModel.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 29/06/21.
//

import Foundation
import UIKit

class TableViewViewModel {
    
    enum action {
        case onTap(IndexPath)
    }
    
    enum viewToPresent {
        case showDetailView
    }
    
    let store = UserDataStore()
    
}

extension TableViewViewModel {
    
    func getUser() {
        UserService.fetchUsers { users in
            self.store.users = users
        } errorblock: { error in
            print(error)
        }

    }
    
}
