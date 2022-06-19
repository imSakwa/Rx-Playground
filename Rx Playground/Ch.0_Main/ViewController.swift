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

    let itemArr1: [String] = [
        "0_1. Prefetch",
        "0_2. Views & Control",
        "1. Github",
        "2. Daum",
        "3. 중고거래 글쓰기"
    ]
    
    let itemArr2: [String] = [
        "1. KakaoMap",
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
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
            return "Part 4"
        case 1:
            return "Part 5"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let prefetchVC = PrefetchViewController()
                self.navigationController?.pushViewController(prefetchVC, animated: true)
                
            case 1:
                let testButtonVC = TestButtonViewController()
                self.navigationController?.pushViewController(testButtonVC, animated: true)
                
            case 2:
                let githubVC = GithubViewController()
                self.navigationController?.pushViewController(githubVC, animated: true)
                
            case 3:
                let daumVC = DaumMainViewController()
                let rootViewModel = DaumMainViewModel()
                daumVC.bind(rootViewModel)
                self.navigationController?.pushViewController(daumVC, animated: true)
                
            case 4:
                let userGoodsUploadVC = MainViewController()
                let userGoodsUploadViewModel = MainViewModel()
                userGoodsUploadVC.bind(userGoodsUploadViewModel)
                self.navigationController?.pushViewController(userGoodsUploadVC, animated: true)
            default:
                break
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                let findCVSVC = FindCVSViewController()
                let findCVSViewModel = FindCVSViewModel()
                findCVSVC.bind(findCVSViewModel)
                self.navigationController?.pushViewController(findCVSVC, animated: true)
                
            default:
                break
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return itemArr1.count
        case 1:
            return itemArr2.count
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.titleLbl.text = itemArr1[indexPath.row]
        } else if indexPath.section == 1 {
            cell.titleLbl.text = itemArr2[indexPath.row]
        }
        
        return cell
    }
    
    
}

