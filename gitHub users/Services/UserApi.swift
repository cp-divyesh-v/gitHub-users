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
    
    static func fetchUsers(onSuccess:@escaping(([User]) -> Void), onError:@escaping((Error) -> Void)) {
        let url1 = URL(string: "https://api.github.com/users")
        guard let url = url1 else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    onError(error as! Error)
                }
                return
            }
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    onSuccess(result)
                }
            } catch {
                DispatchQueue.main.async {
                    onError(error)
                }
            }
        }.resume()
    }
}
