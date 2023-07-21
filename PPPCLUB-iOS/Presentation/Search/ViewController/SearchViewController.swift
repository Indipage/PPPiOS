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
    
    private var isFiltering: Bool = false
    private var allSpace: [SpaceData] = [] {
        didSet {
            isFiltering = false
            searchView.searchTableView.reloadData()
        }
    }
    private var filteredSpace: [SpaceData] = [] {
        didSet {
            searchView.searchTableView.reloadData()
        }
    }
    private var isResultExisted: Bool = true {
        didSet {
            showNoResultImage(isExisted: isResultExisted)
        }
    }
    
    // MARK: - UI Components
    
    private lazy var searchView = SearchView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        register()
        delegate()
        
        hierarchy()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        requestGetAllSpace()
    }
    
    // MARK: - Custom Method

    private func register() {
        searchView.searchTableView.register(SearchTableViewCell.self,
                                            forCellReuseIdentifier: SearchTableViewCell.cellIdentifier)
    }

    private func delegate() {
        searchView.searchTableView.dataSource = self
        searchView.searchTableView.delegate = self
        searchView.searchBar.delegate = self
    }

    private func hierarchy() {
        view.addSubviews(searchView)
    }

    private func layout() {
        searchView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Size.tabBarHeight-16)
        }
    }
    
    private func showNoResultImage(isExisted: Bool) {
        searchView.searchTableView.isHidden = !isExisted
        searchView.noResultImageView.isHidden = isExisted
        searchView.noResultLabelStackView.isHidden = isExisted
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDelegate {}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredSpace.count
        } else {
            return allSpace.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier,
                                                 for: indexPath) as? SearchTableViewCell ?? SearchTableViewCell()
        cell.selectionStyle = .none
        
        if isFiltering {
            cell.id = filteredSpace[indexPath.row].spaceID
            cell.dataBind(image: filteredSpace[indexPath.row].imageURL,
                           name: filteredSpace[indexPath.row].spaceName,
                           location: filteredSpace[indexPath.row].address
            )
        } else {
            cell.id = allSpace[indexPath.row].spaceID
            cell.dataBind(image: allSpace[indexPath.row].imageURL,
                          name: allSpace[indexPath.row].spaceName,
                          location: allSpace[indexPath.row].address
            )
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchTableViewCell else { return }
        let detailViewController = DetailViewController()
        detailViewController.dataBind(spaceID: cell.id)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchView.searchBar.text == "" {
            self.searchView.searchBar.resignFirstResponder()
            self.isFiltering = false
            requestGetAllSpace()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = true
        requestGetSearchSpace(keyword: searchView.searchBar.text ?? String())
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isFiltering = true
        requestGetSearchSpace(keyword: searchView.searchBar.text ?? String())
    }
}

extension SearchViewController {
    private func requestGetSearchSpace(keyword: String) {
        SearchAPI.shared.getSearchSpace(keyword: keyword) { result in
            guard let result = self.validateResult(result) as? [SpaceData] else { return }
            if result.count == 0 {
                self.isResultExisted = false
            } else {
                self.isResultExisted = true
                self.filteredSpace = result
            }
            dump(result)
        }
    }
    
    private func requestGetAllSpace() {
        SearchAPI.shared.getAllSpace { result in
            guard let result = self.validateResult(result) as? [SpaceData] else { return }
            self.isResultExisted = true
            self.allSpace = result
        }
    }
}
