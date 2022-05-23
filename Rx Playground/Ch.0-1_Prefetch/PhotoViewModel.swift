//
//  PhotoViewModel.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/05/23.
//

import Foundation
import UIKit

class PhotoViewModel {
    var dataSource: UITableViewDiffableDataSource<Section, Photo>!
    lazy var provider: Provider = Pro
}
