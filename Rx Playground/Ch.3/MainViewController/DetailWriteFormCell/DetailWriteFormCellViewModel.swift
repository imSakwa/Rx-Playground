//
//  DetailWriteFormCellViewModel.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/12.
//

import RxCocoa
import RxSwift

struct DetailWriteFormCellViewModel {
    // View -> ViewModel
    let contentValue = PublishRelay<String?>()
}
