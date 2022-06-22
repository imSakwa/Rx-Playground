//
//  LocalNetworkSub.swift
//  Rx PlaygroundTests
//
//  Created by ChangMin on 2022/06/22.
//

import Foundation
import RxSwift
import Stubber

@testable import Rx_Playground

class LocalNetworkStub: LocalNetwork {
    override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        
        return Stubber.invoke(getLocation, args: mapPoint)
    }
}
