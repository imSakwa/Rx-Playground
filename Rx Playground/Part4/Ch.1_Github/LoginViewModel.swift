//
//  LoginViewModel.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/03/27.
//

import RxSwift
import RxRelay

class LoginViewModel {
    
    let idObserver = BehaviorRelay<String>(value: "")
    let pwObserver = BehaviorRelay<String>(value: "")
}
