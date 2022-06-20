//
//  DetailListBackgroundView.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/20.
//

import RxCocoa
import RxSwift
import SnapKit

class DetailListBackgroundView: UIView {
    private let disposeBag = DisposeBag()
    private let statusLbl = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
        
    func bind(_ viewModel: DetailListBackgrounViewModel) {
        viewModel.isStatusLblHidden
            .emit(to: statusLbl.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        backgroundColor = .white
        
        statusLbl.text = "🔆"
        statusLbl.textAlignment = .center
    }
    
    private func layout() {
        addSubview(statusLbl)
        
        statusLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
