//
//  TableViewViewModel.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 29/06/21.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class TableViewViewModel {
    
    lazy var disposeBag = DisposeBag()
    
    let didActionSubject: PublishSubject<Action> = .init()
    
    enum Action {
        case onTap(IndexPath)
    }
    
    var shouldPresentSubject: PublishSubject<ViewToPresent> = .init()
    
    enum ViewToPresent {
        case showDetailView(DetailViewModel)
    }
    
    let store = UserDataStore()
    
    let cells: BehaviorRelay<[CellModel]>
    
    init() {
        cells = .init(value: [])
        getUser()
        setUpRxObserver()
    }
    
}

extension TableViewViewModel {
    
    func getUser() {
        ApiService.fetchUsers { users in
            self.store.users = users
            self.cells.accept(self.prepareCell())
        } errorblock: { error in
            print(error)
        }
    }
    
    func prepareCell() -> [CellModel]{
        let cells = store.users
        return cells.map({CellModel(name: $0.login)})
    }
    
    func handleShowDetailView(user: UserModel) {
        let viewModel = DetailViewModel(user: user)
        self.shouldPresentSubject.onNext(.showDetailView(viewModel))
    }
    
    func setUpRxObserver() {
        setUpActonObserver()
    }
    
    func setUpActonObserver() {
        didActionSubject.asObservable()
            .subscribe(onNext: { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .onTap(let indexPath):
                    let user = self.store.users[indexPath.row]
                    self.handleShowDetailView(user: user)
                }
            }) .disposed(by: disposeBag)
    }
}
