//
//  UserService.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 08/07/21.
//

import Foundation

class UserService: UserApi {
    static func fetchUserFomGit() -> [UserModel] {
        var users = [UserModel]()
        UserApi.fetchUsers(completed: { user in
            users.append(contentsOf: user)
        }, errorblock: { error in
            print(error)
        })
        return users
    }
}
