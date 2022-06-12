//
//  MainModel.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/12.
//

import Foundation

struct MainModel {
    func setAlert(errorMessage: [String]) -> Alert {
        let title = errorMessage.isEmpty ? "성공" : "실패"
        let message = errorMessage.isEmpty ? nil : errorMessage.joined(separator: "\n")
        
        return (title: title, message: message)
    }
}
