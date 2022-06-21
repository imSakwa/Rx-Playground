//
//  FindCVSViewController.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/19.
//

import UIKit
import RxSwift
import CoreLocation
import RxCocoa
import SnapKit

class FindCVSViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private let locationManager = CLLocationManager()
    let mapView = MTMapView()
    private let currentLocationButton = UIButton()
    let detailList = UITableView()
    private let detailListBackgroundView = DetailListBackgroundView()
    private let viewModel = FindCVSViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        bind(viewModel)
        attribute()
        layout()
    }
    
    func bind(_ viewModel: FindCVSViewModel) {
        detailListBackgroundView.bind(viewModel.detailListBackgroundViewModel)
        
        viewModel.setMapCenter
            .emit(to: mapView.rx.setMapCenterPoint)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .emit(to: self.rx.presentAlert)
            .disposed(by: disposeBag)
        
        viewModel.detailListCellData
            .drive(detailList.rx.items) { tv, row, data in
                let cell = tv.dequeueReusableCell(withIdentifier: "DetailListCell", for: IndexPath(row: row, section: 0)) as! DetailListCell
                cell.setData(data)
                
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.detailListCellData
            .map { $0.compactMap { $0.point }}
            .drive(self.rx.addPOIItem)
            .disposed(by: disposeBag)
        
        viewModel.scrollToSelectedLocation
            .emit(to: self.rx.showSelectedLocation)
            .disposed(by: disposeBag)
        
        detailList.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.detailListItemSelected)
            .disposed(by: disposeBag)
        
        currentLocationButton.rx.tap
            .bind(to: viewModel.currentLocationButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "내 주변 편의점 찾기"
        view.backgroundColor = .white
        
        mapView.currentLocationTrackingMode = .onWithoutHeadingWithoutMapMoving
        
        currentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        currentLocationButton.backgroundColor = .white
        currentLocationButton.layer.cornerRadius = 20
        
        detailList.register(DetailListCell.self, forCellReuseIdentifier: "DetailListCell")
        detailList.separatorStyle = .none
        detailList.backgroundView = detailListBackgroundView
    }
    
    private func layout() {
        [mapView, currentLocationButton, detailList]
            .forEach { view.addSubview($0) }
        
        mapView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.snp.centerY).offset(100)
        }
        
        currentLocationButton.snp.makeConstraints {
            $0.bottom.equalTo(detailList.snp.top).offset(-12)
            $0.leading.equalToSuperview().inset(12)
            $0.size.equalTo(40)
        }
        
        detailList.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom)
            $0.centerX.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }
}

extension FindCVSViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,
                .authorizedWhenInUse,
                .notDetermined:
            return
        default:
            viewModel.mapViewError.accept(MTMapViewError.locationAuthorizationDenied.errorDescription)
            return
        }
    }
}

extension FindCVSViewController: MTMapViewDelegate {
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        #if DEBUG
            viewModel.currentLocation.accept(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.394225, longitude: 127.110341)))
        #else
            viewModel.currentLocation.accept(location)
        #endif
        
    }
    
    func mapView(_ mapView: MTMapView!, finishedMapMoveAnimation mapCenterPoint: MTMapPoint!) {
        viewModel.mapCenterPoint.accept(mapCenterPoint)
    }
    
    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
        viewModel.selectPOIItem.accept(poiItem)
        return false
    }
    
    func mapView(_ mapView: MTMapView!, failedUpdatingCurrentLocationWithError error: Error!) {
        viewModel.mapViewError.accept(error.localizedDescription)
    }
}

extension Reactive where Base: MTMapView {
    var setMapCenterPoint: Binder<MTMapPoint> {
        return Binder(base) { base, point in
            base.setMapCenter(point, animated: true)
        }
    }
}

extension Reactive where Base: FindCVSViewController {
    var presentAlert: Binder<String> {
        return Binder(base) { base, message in
            let alertController = UIAlertController(title: "문제가 발생했다.", message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "확인", style: .default)
            
            alertController.addAction(action)
            
            base.present(alertController, animated: true)
        }
    }
    
    var showSelectedLocation: Binder<Int> {
        return Binder(base) { base, row in
            let indexPath = IndexPath(row: row, section: 0)
            
            base.detailList.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        }
    }
    
    var addPOIItem: Binder<[MTMapPoint]> {
        return Binder(base) { base, points in
            let item = points
                .enumerated()
                .map { offset, point -> MTMapPOIItem in
                    let mapPOIItem = MTMapPOIItem()
                    mapPOIItem.mapPoint = point
                    mapPOIItem.markerType = .redPin
                    mapPOIItem.showAnimationType = .springFromGround
                    mapPOIItem.tag = offset
                    
                    return mapPOIItem
                }
            
            base.mapView.removeAllPOIItems()
            base.mapView.addPOIItems(item)
        }
    }
}

