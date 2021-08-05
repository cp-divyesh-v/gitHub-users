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
    let profileCell: BehaviorRelay<[ProfileCellModel]>
    let repos: BehaviorRelay<[CellModel]>
    
    let repoStore = RepoStore()
    let avatarStore = AvatarStore()
    
    
    init(user:UserModel) {
        self.user = user
        self.profileCell = .init(value: [])
        self.repos = .init(value: [])
    }
    
    func fetchImage(from url: String) {
        AvatarApi.downloadImage(from: user.avatarURL) { img in
            self.avatarStore.avatar[self.user.avatarURL] = img
            self.profileCell.accept(self.prepareCellForAvatar())
        } onError: { error in
            print("Downloding image fail \(error)")
        }

    }
    
    func getRepo() {
        RepoApi.fetchRepo(from: user.reposURL) { repos in
            self.repoStore.repos = repos
            self.repos.accept(self.prepareCellForRepo())
        } onError: { error in
            print("error occure in faching repositroty \(error)")
        }
        repos.accept(prepareCellForRepo())
    }
    
    func prepareCellForRepo() -> [CellModel] {
        let cell = repoStore.repos
        return cell.map({CellModel(name: $0.name)})
    }
    
    func prepareCellForAvatar() -> [ProfileCellModel] {
        let avatarImg = avatarStore.avatar[user.avatarURL]
        if let img = avatarImg {
            return [ProfileCellModel(avatar: img)]
        }
        return []
    }
}
