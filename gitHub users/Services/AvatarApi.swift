//
//  AvatarApi.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 02/08/21.
//

import Foundation
import UIKit


class AvatarApi {
    
    static func downloadImage(from url: String, onSuccess: @escaping (UIImage) -> (), onError: @escaping (Error) -> ()) {
        let url = URL(string: url)
        guard let url = url else { return }
        getData(from: url) { data, response, error in
            if let error = error {
                onError(error)
            }
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            guard let img = UIImage(data: data) else { return }
            onSuccess(img)
        }
    }
}
