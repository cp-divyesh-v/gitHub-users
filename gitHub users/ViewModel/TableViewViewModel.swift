//
//  TableViewViewModel.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 29/06/21.
//

import Foundation
import UIKit

class TableViewViewModel {

    let api: UserApi
    
    init(gihubApi: UserApi) {
        api = gihubApi
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
