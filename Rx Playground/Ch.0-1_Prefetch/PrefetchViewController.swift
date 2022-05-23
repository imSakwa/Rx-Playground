//
//  PrefetchViewController.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/05/22.
//

import UIKit
import SnapKit
import Alamofire
import RxSwift
import Then

class PrefetchViewController: UIViewController {
    
    private let viewModel = PhotoViewModel()
    
    lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.prefetchDataSource = self
        $0.register(PrefetchTableViewCell.self, forCellReuseIdentifier: PrefetchTableViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        viewModel.dataSource = UITableViewDiffableDataSource<Section, Photo>(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, photo in
            
            
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        setupSubview()
        setupConstraint()
    }
    
    private func setupSubview() {
        view.addSubview(tableView)
    }
    private func setupConstraint() {
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension PrefetchViewController: UITableViewDelegate, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
