//
//  TestButtonViewController.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/05/30.
//

import UIKit
import RxSwift
import SnapKit
import Then
import RxRelay

class TestButtonViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let countRelay = BehaviorRelay<Int>(value: 0)
    
    let button = UIButton().then {
        $0.backgroundColor = .systemMint
        $0.setTitle("테스트 버튼", for: .normal)
    }
    
    let countLbl = UILabel().then {
        $0.text = "0"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
    }
    
    let button2 = UIButton().then {
        $0.backgroundColor = .systemMint
        $0.setTitle("Bool 버튼", for: .normal)
    }
    
    let countLbl2 = UILabel().then {
        $0.text = "짠"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.button.rx.tap
            .map { 1 } // map -> 이벤트 변환.
            .bind(to: self.countRelay)
            .disposed(by: disposeBag)
        
        self.countRelay // $0: 이전 값, $1: 들어오는 값?
            .scan(0, accumulator: { // 0: 초기값, accumulator : 각 요소에서 호출한다. 여기선 이전 값과 현재 값의 합이 15 까지만 동작
                if $0 + $1 <= 15 {
                    print("\($0), \($1)")
                    return $0 + $1
                } else {
                    return $0
                }
            })
            .withUnretained(self)
            .bind { $0.countLbl.text = "\($1)"}
            .disposed(by: disposeBag)
    
        /**
         - ObserverType -> 값을 방출할 수 있는 타입 (주입 시킬 수 있는)
         - ObservableType -> 값을 받을 수 있는 타입 (관찰 할 수 있는)
         
         - ControlProperty -> 주입도 가능하고 관찰도 가능
         - Binder -> ObserverType을 따른다 = 주입은 가능하지만 관찰은 불가능
         
         
         **/
        
        self.button2.rx.tap
            .scan(false) { (last, new) in
                !last
            }
            .bind(to: self.countLbl2.rx.isHidden)
            .disposed(by: disposeBag)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        setupSubview()
        setupConstraint()
    }
    
    private func setupSubview() {
        view.addSubview(countLbl)
        view.addSubview(button)
        
        view.addSubview(countLbl2)
        view.addSubview(button2)
    }
    private func setupConstraint() {
        countLbl.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.centerX.equalToSuperview().offset(-50)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(countLbl.snp.bottom).offset(10)
            $0.centerX.equalTo(countLbl)
            $0.height.equalTo(30)
        }
        
        countLbl2.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.centerX.equalToSuperview().offset(50)
        }
        
        button2.snp.makeConstraints {
            $0.top.equalTo(countLbl2.snp.bottom).offset(10)
            $0.centerX.equalTo(countLbl2)
            $0.height.equalTo(30)
        }
    }
}
