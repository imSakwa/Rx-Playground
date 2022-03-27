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

    private let listTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "listCell")
        
        setLayout()
    }
    
    private func setLayout() {
        self.view.addSubview(listTableView)
        listTableView.snp.makeConstraints {
            $0.size.edges.equalToSuperview()
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
            return "생각하지 못한 섹션.."
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
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

