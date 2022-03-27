//
//  ListTableViewCell.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/03/27.
//

import UIKit
import SnapKit
import Then

class ListTableViewCell: UITableViewCell {
    
    let titleLbl = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 15)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.contentView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
    }
}
