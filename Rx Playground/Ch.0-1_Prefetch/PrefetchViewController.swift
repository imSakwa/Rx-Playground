//
//  PrefetchViewController.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/05/22.
//

import UIKit
import SnapKit
import Alamofire
import RxSwift
import RxCocoa
import Then

class PrefetchViewController: UIViewController {
    
    private let viewModel = PhotoViewModel()
    
    var stringArr = ["일일일일일일"] {
        didSet {
            self.textTableView.reloadData()
        }
    }
    var values = BehaviorRelay<[String]>(value: [])
    var disposeBag = DisposeBag()
    
    lazy var textTableView = UITableView().then {
        $0.register(PrefetchTableViewCell.self, forCellReuseIdentifier: PrefetchTableViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        // 테이블 뷰에 데이터 추가
        stringArr.append("이이이이이")
        stringArr.append("삼삼삼삼삼삼")
        stringArr.append("사사사사사사사")
        values.accept(stringArr)
    }
    
    private func setupTableView() {
        textTableView.rowHeight = UITableView.automaticDimension
        
        values
            .observe(on: MainScheduler.instance)
            .bind(to: textTableView.rx.items) {(tableView: UITableView, index: Int, element: String) in
                let indexPath = IndexPath(row: index, section: 0)
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PrefetchTableViewCell.identifier, for: indexPath) as? PrefetchTableViewCell else { return UITableViewCell() }
                cell.title.text = element
                
                return cell
            }
            .disposed(by: disposeBag)
        
        // 셀 선택 시 인덱스 반환 (model 사용하면 modelSelected 사용하기)
        textTableView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { indexPath in
                    print("선택: \(indexPath.row)")
                }
            )
            .disposed(by: disposeBag)
          
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        setupSubview()
        setupConstraint()
    }
    
    private func setupSubview() {
        view.addSubview(textTableView)
    }
    private func setupConstraint() {
        textTableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

