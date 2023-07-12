//
//  HomeArticleViewController.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/12.
//

import UIKit

import SnapKit
import Then


class HomeArticleViewController: UIViewController {
    
    // MARK: - Properties
//    private var scrollRowHeight = HomeArticleHeaderView().headerHeight ?? 0
    
    // MARK: - UI Components
    private let rootView = HomeArticleView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
        register()
        delegate()
        
        style()
        hierarchy()
        layout()
    }
    
    // MARK: - Custom Method
    
    private func target() {
        
    }
    
    private func register() {
        
    }
    
    private func delegate() {
        rootView.articleTableView.delegate = self
        rootView.articleTableView.dataSource = self
    }
    
    private func style() {
    }
    
    private func hierarchy() {
    }
    
    private func layout() {
    }
    
    //MARK: - Action Method
    
}

extension HomeArticleViewController: UITableViewDelegate {
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> Int {
        return 475
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeArticleHeaderView.cellIdentifier) as? HomeArticleHeaderView else { return UIView()}
        return header
    }
}

extension HomeArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
}
