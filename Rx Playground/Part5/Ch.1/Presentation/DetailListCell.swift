//
//  DetailListCell.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/20.
//

import UIKit
import SnapKit

class DetailListCell: UITableViewCell {
    private let placeNameLbl = UILabel()
    private let addressLbl = UILabel()
    private let distanceLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    func setData(_ data: DetailListCellData) {
        placeNameLbl.text = data.placeName
        addressLbl.text = data.address
        distanceLbl.text = data.distance
        
    }
    
    private func attribute() {
        backgroundColor = .white
        placeNameLbl.font = .systemFont(ofSize: 16, weight: .bold)
        
        addressLbl.font = .systemFont(ofSize: 14)
        addressLbl.textColor = .gray
        
        distanceLbl.font = .systemFont(ofSize: 12, weight: .light)
        distanceLbl.textColor = .darkGray
    }
    
    private func layout() {
        [placeNameLbl, addressLbl, distanceLbl]
            .forEach { contentView.addSubview($0) }
        
        placeNameLbl.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(18)
        }
        
        addressLbl.snp.makeConstraints {
            $0.top.equalTo(placeNameLbl.snp.bottom).offset(3)
            $0.leading.equalTo(placeNameLbl)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        distanceLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
