//
//  UserService.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 08/07/21.
//

import Foundation

class ApiService {
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
extension ApiService {
    static func fetchRepo(url: String) -> [RepoModel] {
        var repository = [RepoModel]()
        RepoApi.fetchRepo(from: url) { repos in
            repository = repos
        } onError: { error in
            print("problem occured in fatching repos from remote error \(error)")
        }
        return repository
    }
}


