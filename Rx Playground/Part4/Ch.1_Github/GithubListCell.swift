//
//  GithubListCell.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/05/19.
//

import UIKit
import SnapKit

class GithubListCell: UITableViewCell {
    var repository: Repository?
    
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
        
        guard let repository = repository else {
            return
        }
        nameLbl.text = repository.name
        nameLbl.font = .systemFont(ofSize: 15, weight: .bold)
        
        descriptionLbl.text = repository.description
        descriptionLbl.font = .systemFont(ofSize: 15)
        descriptionLbl.numberOfLines = 2
        
        starImgView.image = UIImage(systemName: "star")
        
        starLbl.text = "\(repository.stargazersCount)"
        starLbl.font = .systemFont(ofSize: 16)
        starLbl.textColor = .gray
        
        languageLbl.text = repository.language
        languageLbl.font = .systemFont(ofSize: 16)
        languageLbl.textColor = .gray
        
        nameLbl.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }
        
        descriptionLbl.snp.makeConstraints {
            $0.top.equalTo(nameLbl.snp.bottom).offset(3)
            $0.leading.trailing.equalTo(nameLbl)
        }
        
        starImgView.snp.makeConstraints {
            $0.top.equalTo(descriptionLbl.snp.bottom).offset(8)
            $0.leading.equalTo(descriptionLbl)
            $0.width.height.equalTo(20)
            $0.bottom.equalToSuperview().inset(18)
        }
        
        starLbl.snp.makeConstraints {
            $0.centerY.equalTo(starImgView.snp.centerY)
            $0.leading.equalTo(starImgView.snp.trailing).offset(5)
        }
        
        languageLbl.snp.makeConstraints {
            $0.centerY.equalTo(starLbl)
            $0.leading.equalTo(starLbl.snp.trailing).offset(12)
        }
    }
}
