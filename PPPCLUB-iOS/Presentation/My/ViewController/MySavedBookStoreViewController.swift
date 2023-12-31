//
//  MySavedBookStoreController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MySavedBookStoreViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var savedSpaceData: [MySavedSpaceResult] = [] {
        didSet {
            rootView.savedBookStoreTableView.reloadData()
        }
    }
    
    //MARK: - UI Components
    
    let rootView = MySavedBookStoreView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
        delegate()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        requestSavedSpaceAPI()
    }
    
    //MARK: - Custom Method
    
    private func target() {
        rootView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    private func delegate() {
        rootView.savedBookStoreTableView.delegate = self
        rootView.savedBookStoreTableView.dataSource = self
    }
    
    //MARK: - Action Method
    
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UICollectionViewDelegate

extension MySavedBookStoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.dataBind(spaceID: savedSpaceData[indexPath.row].id)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK: - UICollectionViewDataSource

extension MySavedBookStoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedSpaceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.dataBind(mySavedSpaceResult: savedSpaceData[indexPath.row])
        return cell
    }
}

//MARK: - SavedArticleCellDelegate

extension MySavedBookStoreViewController {
    func requestSavedSpaceAPI() {
        MyAPI.shared.getSavedSpace() { result in
            guard let result = self.validateResult(result) as? [MySavedSpaceResult] else { return }
            self.savedSpaceData = result
            if self.savedSpaceData.isEmpty { self.rootView.noSavedSpaceView.isHidden = false }
        }
    }
}

