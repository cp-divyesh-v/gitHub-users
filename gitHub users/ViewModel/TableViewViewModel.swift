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
    
    
}

extension TableViewViewModel {
    
    func fetchUsers(onSuccess:@escaping(([User]) -> Void), onError:@escaping((Error) -> Void)) {
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
