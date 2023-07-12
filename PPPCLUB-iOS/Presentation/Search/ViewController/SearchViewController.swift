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
    private var filter = [SearchList]()
    private var isFiltering: Bool = false
    
    // MARK: - UI Components
    
    private lazy var searchView = SearchView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        register()
        delegate()
        
        style()
        hierarchy()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dismissKeyboardWhenTappedAround()
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

    private func style() {}

    private func hierarchy() {
        view.addSubviews(searchView)
    }

    private func layout() {
        searchView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func isSearchBarEmpty() -> Bool {
        return searchView.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        isFiltering = true
        filter = dummy.filter({(place: SearchList) -> Bool in
            return place.location.lowercased().contains(searchText.lowercased())
        })
        searchView.searchHeaderView.allLabel.text = searchText
        searchView.searchBar.resignFirstResponder()
        searchView.searchTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDelegate {}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filter.count
        } else {
            return dummy.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier,
                                                 for: indexPath) as? SearchTableViewCell ?? SearchTableViewCell()
        cell.selectionStyle = .none
        if isFiltering {
            cell.dataBind(image: filter[indexPath.row].image,
                          name: filter[indexPath.row].name,
                          location: filter[indexPath.row].location)
        } else {
            cell.dataBind(image: dummy[indexPath.row].image,
                          name: dummy[indexPath.row].name,
                          location: dummy[indexPath.row].location)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchView.searchHeaderView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchView.searchBar.text == "" {
            self.searchView.searchBar.resignFirstResponder()
            self.searchView.searchHeaderView.allLabel.text = "전체"
            self.isFiltering = false
            self.searchView.searchTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterContentForSearchText(searchView.searchBar.text ?? String())
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchView.searchTableView.reloadData()
    }
}
