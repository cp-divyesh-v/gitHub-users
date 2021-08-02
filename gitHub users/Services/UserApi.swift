//
//  UserApi.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 25/06/21.
//

import Foundation

enum Api {
    case userApi
    case profileApi(id: Int)
}
extension Api {
    
    var baseUrl:String {
        switch self {
        case .userApi:
            return "https://api.github.com/users"
        case .profileApi(let id ):
            return "https://avatars.githubusercontent.com/u/\(id)?v=4"
        }
    }
}


class UserApi {
    
    public static func fetchUsers(completed: @escaping ([UserModel]) -> (), errorblock: @escaping ( (Error) -> () )) {
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
    
}
