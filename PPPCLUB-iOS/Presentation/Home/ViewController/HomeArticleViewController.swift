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
        rootView.articleNavigationView.articleBackButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
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
    
    @objc
    func backButtonTap() {
        self.dismiss(animated: true)
    }
    
}

//MARK: - UITableViewDelegate

extension HomeArticleViewController: UITableViewDelegate {
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> Int {
        return 475
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeArticleHeaderView.cellIdentifier) as? HomeArticleHeaderView else { return UIView()}
        return header
    }
    
    private func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> Int {
        return 692
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeArticleFooterView.cellIdentifier) as? HomeArticleFooterView else { return UIView()}
        return footer
    }
}

//MARK: - UITableViewDataSource

extension HomeArticleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeArticleTableViewCell.cellIdentifier, for: indexPath) as? HomeArticleTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
