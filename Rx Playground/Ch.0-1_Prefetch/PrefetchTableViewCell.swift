//
//  PrefetchTableViewCell.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/05/23.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import Then

class PrefetchTableViewCell: UITableViewCell {
    static let identifier = "PrefetchTableViewCell"
    var disposeBag = DisposeBag()
    
    let title = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(title)
        
        title.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
}
