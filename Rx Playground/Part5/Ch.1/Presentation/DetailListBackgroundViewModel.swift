//
//  DetailListBackgroundViewModel.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/20.
//

import RxSwift
import RxCocoa

struct DetailListBackgrounViewModel {
    // viewModel -> view
    let isStatusLblHidden: Signal<Bool>
    
    // 외부에서 전달받은 값
    let shouldHideStatusLbl = PublishSubject<Bool>()
    
    init() {
        isStatusLblHidden = shouldHideStatusLbl
            .asSignal(onErrorJustReturn: true)
    }
}
