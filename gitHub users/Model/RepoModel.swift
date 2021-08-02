//
//  RepoModel.swift
//  gitHub users
//
//  Created by Divyesh Vekariya on 29/07/21.
//

import Foundation
import UIKit

struct RepoModel: Decodable {
    let name: String
}

public class RepoStore {
    var repos = [RepoModel]()
}

