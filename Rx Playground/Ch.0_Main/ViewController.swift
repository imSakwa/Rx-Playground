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

    private let naviBarView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let titleLbl = UILabel().then {
        $0.text = "RxSwift Playground"
        $0.font = .boldSystemFont(ofSize: 22)
    }
    
    private let addBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 22, weight: .regular, scale: .default), forImageIn: .normal)
        $0.addTarget(self, action: #selector(clickAddBtn), for: .touchUpInside)
        $0.contentMode = .scaleAspectFill
        $0.tintColor = .black
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
    
    // 리스트 추가하기 (근데 왜 만들었지..?)
    @objc private func clickAddBtn(_ sender: UIButton) {
        print("clicked!!!")
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
        
        naviBarView.addSubview(addBtn)
        addBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
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
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.titleLbl.text = "가가가가ㅏ가가가가가가ㅏ가가가가ㅏ가가가가ㅏ가가가가ㅏ가가가가ㅏㄱ"
        return cell
    }
    
    
}

