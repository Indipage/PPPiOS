//
//  ArticleViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    var articleID: Int?
    
    private var articleCardData: HomeArticleCardResult?  {
        didSet {
            rootView.homeWeeklyView.dataBindArticleCard(articleData: articleCardData)
        }
    }
    
    private var articleSlideCheckData: HomeArticleCheckResult? {
        didSet {
            rootView.homeWeeklyView.dataBindArticleSlideCheck(articleData: articleSlideCheckData)
        }
    }
    
    private var articleAllData: [HomeArticleListResult] = [] {
        didSet {
            rootView.homeAllView.allArticleCollectionView.reloadData()
        }
    }
    
    // MARK: - UI Components
    
    private let rootView = HomeView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gesture()
        target()
        delegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        requestArticleCardAPI()
        requestSlideCheckAPI()
        requestAllArticleAPI()
    }
    
    // MARK: - Custom Method
    
    private func gesture() {
        let gesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self,
                                         action: #selector(ticketCaseMoved(_:)))
        rootView.homeWeeklyView.ticketCoverImageView.addGestureRecognizer(gesture)
    }
    
    private func target() {
        rootView.homeNavigationView.weeklyButton.addTarget(self, action: #selector(weeklyButtonTap), for: .touchUpInside)
        rootView.homeNavigationView.allButton.addTarget(self, action: #selector(allButtonTap), for: .touchUpInside)
    }
    
    private func delegate() {
        rootView.homeAllView.allArticleCollectionView.delegate = self
        rootView.homeAllView.allArticleCollectionView.dataSource = self
    }
    
    //MARK: - Action Method
    
    @objc func weeklyButtonTap() {
        rootView.homeNavigationView.weeklyButton.isSelected = true
        rootView.homeNavigationView.allButton.isSelected = false
        rootView.homeNavigationView.weeklyButton.backgroundColor = .pppMainPurple
        rootView.homeNavigationView.allButton.backgroundColor = .pppGrey2
        
        rootView.homeWeeklyView.isHidden = false
        rootView.homeAllView.isHidden = true
    }
    
    @objc func allButtonTap() {
        rootView.homeNavigationView.weeklyButton.isSelected = false
        rootView.homeNavigationView.allButton.isSelected = true
        rootView.homeNavigationView.weeklyButton.backgroundColor = .pppGrey2
        rootView.homeNavigationView.allButton.backgroundColor = .pppMainPurple
        
        rootView.homeWeeklyView.isHidden = true
        rootView.homeAllView.isHidden = false
    }
    
    @objc private func ticketCaseMoved(_ sender: UIPanGestureRecognizer) {
        AnimationManager.shared.ticketCoverAnimate(sender, targetView: rootView.homeWeeklyView.ticketCoverImageView) { _ in
            self.ticketDragAnimation()
        }
    }
}

//MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 319, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

//MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleAllData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MySavedArticleCollectionViewCell.cellIdentifier, for: indexPath) as? MySavedArticleCollectionViewCell else { return MySavedArticleCollectionViewCell() }
        cell.delegate = self
        cell.dataBindHome(articleData: articleAllData[indexPath.item])
        return cell
    }
}

//MARK: - SavedArticleCellDelegate

extension HomeViewController: SavedArticleCellDelegate {
    func articleDidTap(articleID: Int?) {
        let articleViewController = HomeArticleViewController(articleID: articleID)
        self.navigationController?.pushViewController(articleViewController, animated: true)
    }
}

extension HomeViewController {
    func pushToArticleViewController() {
        
        let homeArticleVC = HomeArticleViewController(articleID: articleID)
        self.navigationController?.pushViewController(homeArticleVC, animated: true)
        
    }
    
    private func ticketDragAnimation() {
        requestPutSlideAPI()
        pushToArticleViewController()
    }
    
    func requestArticleCardAPI() {
        HomeAPI.shared.getArticleCard() { result in
            guard let result = self.validateResult(result) as? HomeArticleCardResult else { return }
            self.articleCardData = result
            self.articleID = result.id
        }
    }
    
    func requestSlideCheckAPI() {
        HomeAPI.shared.getArticleCheck() { result in
            guard let result = self.validateResult(result) as? HomeArticleCheckResult else { return }
            self.articleSlideCheckData = result
        }
    }
    
    func requestPutSlideAPI() {
        HomeAPI.shared.putArticleCheck() { result in
            guard let result = self.validateResult(result) else { return }
        }
    }

    func requestAllArticleAPI() {
        HomeAPI.shared.getAllArticle() { result in
            guard let result = self.validateResult(result) as? [HomeArticleListResult] else { return }
            self.articleAllData = result
        }
    }
}
