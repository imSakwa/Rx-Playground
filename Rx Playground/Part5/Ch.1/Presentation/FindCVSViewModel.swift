//
//  FindCVSViewModel.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/19.
//

import RxCocoa
import RxSwift
import RxRelay

struct FindCVSViewModel {
    private let disposeBag = DisposeBag()
    
    // subViewModel
    let detailListBackgroundViewModel = DetailListBackgrounViewModel()
    
    // viewModel -> view
    let setMapCenter: Signal<MTMapPoint>
    let errorMessage: Signal<String>
    let detailListCellData: Driver<[DetailListCellData]>
    let scrollToSelectedLocation: Signal<Int>
    
    // view -> viewModel
    let currentLocation = PublishRelay<MTMapPoint>()
    let mapCenterPoint = PublishRelay<MTMapPoint>()
    let selectPOIItem = PublishRelay<MTMapPOIItem>()
    let mapViewError = PublishRelay<String>()
    let currentLocationButtonTapped = PublishRelay<Void>()
    let detailListItemSelected = PublishRelay<Int>()
    
    let documentData = PublishSubject<[KLDocument?]>()
    
    init() {
        // 지도 중심점 설정
        let selectedDetailListItem = detailListItemSelected
            .withLatestFrom(documentData) { $1[$0] }
            .map { data -> MTMapPoint in
                guard let data = data,
                      let logitude = Double(data.x),
                      let latitude = Double(data.y) else {
                    return MTMapPoint()
                }
                
                let geoCoord = MTMapPointGeo(latitude: latitude, longitude: logitude)
                return MTMapPoint(geoCoord: geoCoord)
            }
            
        
        let moveToCurrentLocation = currentLocationButtonTapped
            .withLatestFrom(currentLocation)
        
        // 3개 이벤트에 따라 맵의 중심을 이동
        let currentMapCenter = Observable
            .merge(
                selectedDetailListItem,
                currentLocation.take(1),
                moveToCurrentLocation
            )
        
        setMapCenter = currentMapCenter
            .asSignal(onErrorSignalWith: .empty())
        
        errorMessage = mapViewError.asObservable()
            .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요.")
        
        detailListCellData = Driver.just([])
        
        scrollToSelectedLocation = selectPOIItem
            .map { $0.tag }
            .asSignal(onErrorJustReturn: 0)
    }
}
