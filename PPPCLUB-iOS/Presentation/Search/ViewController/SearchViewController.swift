//
//  SearchViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let dummy = SearchListModel.dummy()
    
    // MARK: - UI Components
    
    private lazy var searchView = SearchView()
    
    // MARK: - Life Cycles
    
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

    private func target() {}

    private func register() {
        searchView.searchTableView.register(SearchTableViewCell.self,
                                            forCellReuseIdentifier: SearchTableViewCell.cellIdentifier)
    }

    private func delegate() {
        searchView.searchTableView.dataSource = self
        searchView.searchTableView.delegate = self
    }

    private func style() {}

    private func hierarchy() {
        view.addSubviews(searchView)
    }

    private func layout() {
        searchView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.preservesSuperviewLayoutMargins = true
        cell.contentView.layoutMargins.top = 10 // 셀의 위 간격을 10 포인트로 설정
        cell.contentView.layoutMargins.bottom = 10 // 셀의 아래 간격을 10 포인트로 설정
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier,
                                                 for: indexPath) as? SearchTableViewCell ?? SearchTableViewCell()
        cell.selectionStyle = .none
        cell.dataBind(image: dummy.searchList[indexPath.row].image,
                      name: dummy.searchList[indexPath.row].name,
                      location: dummy.searchList[indexPath.row].location)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
}
