//
//  MySavedArticleController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MySavedArticleViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var savedArticleData: [MySavedArticleResult] = [] {
        didSet {
            rootView.savedArticleCollectionView.reloadData()
        }
    }
    
    //MARK: - UI Components
    
    let rootView = MySavedArticleView()
    
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
        super.viewWillAppear(true)
        
        requestSavedArticleAPI() 
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Custom Method
    
    private func delegate() {
        rootView.savedArticleCollectionView.delegate = self
        rootView.savedArticleCollectionView.dataSource = self
    }
    
    private func target() {
        rootView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UICollectionViewDelegate

extension MySavedArticleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 319, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

//MARK: - UICollectionViewDataSource

extension MySavedArticleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MySavedArticleCollectionViewCell.cellIdentifier, for: indexPath) as? MySavedArticleCollectionViewCell else { return MySavedArticleCollectionViewCell() }
        cell.delegate = self
        cell.dataBind(articleData: savedArticleData[indexPath.item])
        return cell
    }
}

//MARK: - SavedArticleCellDelegate

extension MySavedArticleViewController: SavedArticleCellDelegate {
    func articleDidTap(articleID: Int?) {
        let articleViewController = HomeArticleViewController(articleID: articleID)
        self.navigationController?.pushViewController(articleViewController, animated: true)
    }

    
    private func requestSavedArticleAPI() {
        MyAPI.shared.getSavedArticle() { result in
            guard let result = self.validateResult(result) as? [MySavedArticleResult] else { return }
            self.savedArticleData = result
        }
    }
}
