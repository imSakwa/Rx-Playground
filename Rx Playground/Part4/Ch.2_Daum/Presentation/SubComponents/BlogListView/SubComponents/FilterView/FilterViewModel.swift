//
//  FilterViewModel.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/12.
//

import RxCocoa
import RxSwift

struct FilterViewModel {
    let sortButtonTapped = PublishRelay<Void>()
}
