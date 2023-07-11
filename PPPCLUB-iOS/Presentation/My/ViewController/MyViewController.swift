//
//  MyViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

final class MyViewController: BaseViewController {
    
    let rootView = MyView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        delegate()
    }
    
    private func delegate() {
        rootView.infoTableView.delegate = self
        rootView.infoTableView.dataSource = self
    }
}

extension MyViewController: UITableViewDelegate {}

extension MyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCell.cellIdentifier, for: indexPath) as? MyInfoTableViewCell else {
             return UITableViewCell()
        }
        return cell
    }
}


