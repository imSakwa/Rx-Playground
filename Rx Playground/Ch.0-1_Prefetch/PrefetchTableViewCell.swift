//
//  PrefetchTableViewCell.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/05/23.
//

import Foundation
import UIKit
import RxSwift

class PrefetchTableViewCell: UITableViewCell {
    static let identifier = "PrefetchTableViewCell"
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
}
