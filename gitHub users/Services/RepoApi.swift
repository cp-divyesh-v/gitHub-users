//
//  RepoApi.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 29/07/21.
//

import Foundation

class RepoApi {
    
    public static func fetchRepo(from url: String, onSucces:  @escaping ([RepoModel]) -> (), onError:  @escaping(Error) -> ()) {
        print("url \(url)")
        guard let url = URL(string: url) else { return }
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let repo = try JSONDecoder().decode([RepoModel].self, from: data)
                onSucces(repo)
                print("\(repo)")
            } catch let error {
                onError(error)
                print("JSON Error")
            }
            if let error = error {
                onError(error)
            }
        }
    }
}
