//
//  DaumMainViewController.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/05.
//

import UIKit
import RxSwift
import RxCocoa

class DaumMainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    // let listView
    // let searchBar
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("에러")
    }
    
    private func bind() {
        // UI 컨트롤러와 컴포넌트들 바인딩하는 작업
    }
    
    private func attribute() {
        // 뷰를 꾸미는 작업
        title = "다음 블로그 검색"
        view.backgroundColor = .white
    }
    
    private func layout() {
        // 레이아웃 조정하는 작업
    }
    
    
}
