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
    let profileCell: BehaviorRelay<ProfileCell>
    
    let repoStore = RepoStore()
    let avatarStore = AvatarStore()
    
    
    init(user:UserModel) {
        self.user = user
        currentUserAvatar = .init(value: nil)
    }
    
    func fetchImage(from url: String) {
        self.avatarStore.avatar[user.avatarURL] = AvatarApi.downloadImage(user.avatarURL)
    }
    
    func getRepo() {
        repoStore.repos = ApiService.fetchRepo(url: user.reposURL)
    }
    
    func prepareCellForRepo() -> [CellModel] {
        let cell = repoStore.repos
        return cell.map({CellModel(name: $0.name)})
    }
    
    func prepareCellForAvatar() -> ProfileCell {
        let avatarCell = downloadImage(from: user.avatarURL)
        return avatarCell.map({ProfileCellModel(avatar: $0.)})
    }
}
