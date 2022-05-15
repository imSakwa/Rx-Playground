//
//  ViewController.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/03/26.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class ViewController: UIViewController {

    let itemArr: [String] = [
        "1. Github",
    ]
    
    private let naviBarView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let titleLbl = UILabel().then {
        $0.text = "RxSwift Playground"
        $0.font = .boldSystemFont(ofSize: 22)
    }
        
    private let listTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.navigationController?.navigationBar.isHidden = true
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "listCell")
        
        setLayout()
    }
    
    private func setLayout() {
        self.view.addSubview(naviBarView)
        naviBarView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        naviBarView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        self.view.addSubview(listTableView)
        listTableView.snp.makeConstraints {
            $0.top.equalTo(naviBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "예제"
        case 1:
            return "이론"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let githubVC = GithubViewController()
            self.navigationController?.pushViewController(githubVC, animated: true)
        default:
            break
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.titleLbl.text = itemArr[indexPath.row]
        return cell
    }
    
    
}
