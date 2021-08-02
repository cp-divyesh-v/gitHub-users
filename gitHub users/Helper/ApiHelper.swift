//
//  ApiHelper.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 29/07/21.
//

import Foundation

public func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}
