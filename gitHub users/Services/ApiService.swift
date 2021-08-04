//
//  UserService.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 08/07/21.
//

import Foundation

public class ApiService {
    static func fetchUsers(completed: @escaping ([UserModel]) -> (), errorblock: @escaping ( (Error) -> () )) {
        let url = URL(string:"https://api.github.com/users")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async{
                    errorblock(error)
                }
            } else {
                do {
                    let users = try JSONDecoder().decode([UserModel].self, from: data!)
                    DispatchQueue.main.async{
                        completed(users)
                    }
                } catch let error {
                    print("JSON Error")
                    DispatchQueue.main.async{
                        errorblock(error)
                    }
                }
                
            }
            
        }.resume()
    }
//    static func fetchUserFomGit() -> [UserModel] {
//        var users = [UserModel]()
//            UserApi.fetchUsers(completed: { user in
//            users.append(contentsOf: user)
//        }, errorblock: { error in
//            print(error)
//        })
//        return users
//    }

}
extension ApiService {
    static func fetchRepo(url: String, onSucces: @escaping ([RepoModel]) -> ()){
        RepoApi.fetchRepo(from: url) { repos in
            onSucces(repos)
        } onError: { error in
            print("problem occured in fatching repos from remote error \(error)")
        }
    }
}


