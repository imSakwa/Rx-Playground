//
//  MainViewModel.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/12.
//

import RxCocoa
import RxSwift

struct MainViewModel {
    let disposeBag = DisposeBag()
    
    let blogListViewModel = BlogListViewModel()
    let searchBarViewModel = SearchBarViewModel()
    
    let alertActionTapped = PublishRelay<DaumMainViewController.AlertAction>()
    let shouldPresentAlert: Signal<DaumMainViewController.Alert>
    
    init(model: MainModel = MainModel()) {
        
        let blogResult = searchBarViewModel.shouldLoadResult
            .flatMapLatest(model.searchBlog)
            .share()
        
        let blogValue = blogResult
            .compactMap(model.getBlogValue)
        
        let blogError = blogResult
            .compactMap(model.getBlogError)
        
        // 네트워크를 통해 가져온 값ㅇ르 cellData로 변환
        let cellData = blogValue
            .map(model.getBlogListCellData)
        
//        let currentPage = blogValue
//            .map { blog -> Int in
//                return blog.meta.pageCnt ?? -1
//            }
        
//        listView.rx.prefetchRows
//            .compactMap(\.last?.row)
//            .withUnretained(self)
//            .bind { ss, row in
////                guard row == cellData.count - 1 else { return }
//                SearchBlogNetwork().searchBlog(query: "Rxswift", page: 2)
//            }
        
        // FilterView를 선택했을 때 나오는 alertSheet를 선택했을 때 type
        let sortedType = alertActionTapped
            .filter {
                switch $0 {
                case .title, .datetime:
                    return true
                default:
                    return false
                }
            }
            .startWith(.title)
        
        // MainVC 에서 ListView로 전달하기
        Observable
            .combineLatest(
                sortedType,
                cellData,
                resultSelector: model.sort
            )
            .bind(to: blogListViewModel.blogCellData)
            .disposed(by: disposeBag)
        
        let alertSheetForSorting = blogListViewModel.filterViewModel.sortButtonTapped
            .map { _ -> DaumMainViewController.Alert in
                return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        
        let alertForErrorMessage = blogError
            .map { message -> DaumMainViewController.Alert in
                return (
                    title: "앗!",
                    message: "오류 발생. \(message)",
                    actions: [.confirm],
                    style: .alert
                )
            }
        
        self.shouldPresentAlert = Observable
            .merge(
                alertForErrorMessage,
                alertSheetForSorting
            )
            .asSignal(onErrorSignalWith: .empty())
    }
}
