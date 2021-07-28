//
//  DetailViewModel.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 02/07/21.
//

import Foundation
import UIKit
import RxSwift
import RxRelay


class DetailViewModel {
    
    lazy var disposeBag: DisposeBag = DisposeBag()
    
    let user: UserModel
    let currentUserAvatar: BehaviorRelay<UIImage?>
    
    init(user:UserModel) {
        self.user = user
        currentUserAvatar = .init(value: nil)
    }
    
    func fetchImage(from url: String) {
        let url = URL(string: url)
        guard let url = url else { return }
        downloadImage(from: url)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            guard let img = UIImage(data: data) else { return }
            self.currentUserAvatar.accept(img)
            
        }
    }
    
//    func prepareCell() -> [ProfileCell] {
//        let cell =
//        return cell.map({ProfileCellModel(avatar: T##UIImag)})
//    }
}
