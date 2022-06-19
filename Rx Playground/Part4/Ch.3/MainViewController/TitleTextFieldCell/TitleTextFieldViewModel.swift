//
//  TitleTextFieldViewModel.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/12.
//

import RxCocoa

struct TitleTextFieldViewModel {
    let titleText = PublishRelay<String?>()
}
