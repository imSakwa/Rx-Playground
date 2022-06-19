//
//  AlertActionConvertible.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/05.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
