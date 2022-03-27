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

    private let listTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "listCell")
        
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.titleLbl.text = "test"
        return cell
    }
    
    
}

