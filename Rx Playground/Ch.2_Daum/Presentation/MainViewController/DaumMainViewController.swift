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
    
    private let listView = BlogListView()
    private let searchBar = SearchBar()
    
    
    private var currentPage: Int = 2
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("에러")
    }
    
    func bind(_ viewModel: MainViewModel) {
        listView.bind(viewModel.blogListViewModel)
        searchBar.bind(viewModel.searchBarViewModel)
        
        
        viewModel.shouldPresentAlert
            .flatMapLatest { alert -> Signal<AlertAction> in
                let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
                return self.presentAlertController(alertController, actions: alert.actions)
            }
            .emit(to: viewModel.alertActionTapped)
            .disposed(by: disposeBag)
        
    }
    
    private func attribute() {
        // 뷰를 꾸미는 작업
        title = "다음 블로그 검색"
        view.backgroundColor = .white
    }
    
    private func layout() {
        // 레이아웃 조정하는 작업
        [searchBar, listView].forEach { view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        listView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension DaumMainViewController {
    typealias Alert = (title: String?, message: String?, actions: [AlertAction], style: UIAlertController.Style)
    
    enum AlertAction: AlertActionConvertible {
        case title, datetime, cancel
        case confirm
        
        var title: String {
            switch self {
            case .title:
                return "Title"
            case .datetime:
                return "Datetime"
            case .cancel:
                return "취소"
            case .confirm:
                return "확인"
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .title, .datetime:
                return .default
            case .confirm, .cancel:
                return .cancel
            }
        }
    }
    
    func presentAlertController<Action: AlertActionConvertible>(_ alertController: UIAlertController, actions: [Action]) -> Signal<Action> {
        if actions.isEmpty { return .empty() }
        return Observable
            .create { [weak self] observer in
                guard let self = self else { return Disposables.create() }
                for action in actions {
                    alertController.addAction(
                        UIAlertAction(
                            title: action.title,
                            style: action.style,
                            handler: { _ in
                            observer.onNext(action)
                            observer.onCompleted()
                        })
                    )
                }
                self.present(alertController, animated: true)
                
                return Disposables.create {
                    alertController.dismiss(animated: true)
                }
            }
            .asSignal(onErrorSignalWith: .empty())
    }
}
