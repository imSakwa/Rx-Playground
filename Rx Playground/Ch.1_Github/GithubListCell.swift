//
//  GithubListCell.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/05/19.
//

import UIKit
import SnapKit

class GithubListCell: UITableViewCell {
    var repository: String?
    
    let nameLbl = UILabel()
    let descriptionLbl = UILabel()
    let starImgView = UIImageView()
    let starLbl = UILabel()
    let languageLbl = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [
            nameLbl, descriptionLbl,
            starImgView, starLbl, languageLbl
        ].forEach {
            contentView.addSubview($0)
        }
    }
}
