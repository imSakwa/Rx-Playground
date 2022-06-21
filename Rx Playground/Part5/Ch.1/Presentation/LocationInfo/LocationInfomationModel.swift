//
//  LocationInfomationModel.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/21.
//

import Foundation
import RxSwift

struct LocationInfomationModel {
    let localNetwork: LocalNetwork
    
    init(localNetwork: LocalNetwork = LocalNetwork()) {
        self.localNetwork = localNetwork
    }
    
    func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        return localNetwork.getLocation(by: mapPoint)
    }
    
    func documentsToCellData(_ data: [KLDocument]) -> [DetailListCellData] {
        return data.map {
            let address = $0.roadAddressName.isEmpty ? $0.addressName : $0.roadAddressName
            let point = documentToMapPoint($0)
            return DetailListCellData(placeName: $0.placeName, address: address, distance: $0.distance, point: point)
        }
    }
    
    func documentToMapPoint(_ doc: KLDocument) -> MTMapPoint {
        let latitude = Double(doc.x) ?? .zero
        let longitude = Double(doc.y) ?? .zero
        return MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitude, longitude: longitude))
    }
}
