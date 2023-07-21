//
//  ArticleViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: BaseViewController{
    
    // MARK: - Properties
    
    var articleID: Int?
    
    private var articleCardData: HomeArticleCardResult?  {
        didSet {
            rootView.homeWeeklyView.homeWeeklySlideYetView.dataBindArticleCard(articleData: articleCardData)
            rootView.homeWeeklyView.homeWeeklySlidedView.reloadData()
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
        rootView.homeWeeklyView.homeWeeklySlideYetView.ticketCoverImageView.addGestureRecognizer(gesture)
    }
    
    private func target() {
        rootView.homeNavigationView.weeklyButton.addTarget(self, action: #selector(weeklyButtonTap), for: .touchUpInside)
        rootView.homeNavigationView.allButton.addTarget(self, action: #selector(allButtonTap), for: .touchUpInside)
    }
    
    private func delegate() {
        rootView.homeAllView.allArticleCollectionView.delegate = self
        rootView.homeAllView.allArticleCollectionView.dataSource = self
        rootView.homeWeeklyView.homeWeeklySlidedView.delegate = self
        rootView.homeWeeklyView.homeWeeklySlidedView.dataSource = self
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
        AnimationManager.shared.ticketCoverAnimate(sender, targetView: rootView.homeWeeklyView.homeWeeklySlideYetView.ticketCoverImageView) { _ in
            self.ticketDragAnimation()
        }
    }
}

//MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case rootView.homeWeeklyView.homeWeeklySlidedView:
            let newtop = Size.height * 0.06
            let newbottom = Size.height * 0.212
            let newside = Size.width * 0.053 * 2
            return UIEdgeInsets(top: newtop, left: newside, bottom: newbottom, right: newside)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case rootView.homeAllView.allArticleCollectionView:
            return CGSize(width: 319, height: 180)
        case rootView.homeWeeklyView.homeWeeklySlidedView:
            var cellHeight = Size.height * 0.58
            var cellwidth = Size.width * 0.786
            return CGSize(width: cellwidth, height: cellHeight)
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case rootView.homeAllView.allArticleCollectionView:
            return 20
        case rootView.homeWeeklyView.homeWeeklySlidedView:
            var spacingCal = Size.width * 0.026
            return spacingCal
        default:
            return 0
        }
    }
}

//MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case rootView.homeAllView.allArticleCollectionView:
            return articleAllData.count
        case rootView.homeWeeklyView.homeWeeklySlidedView:
            return 2
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case rootView.homeAllView.allArticleCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MySavedArticleCollectionViewCell.cellIdentifier, for: indexPath) as? MySavedArticleCollectionViewCell else { return MySavedArticleCollectionViewCell() }
            cell.delegate = self
            cell.dataBindHome(articleData: articleAllData[indexPath.item])
            return cell
        case rootView.homeWeeklyView.homeWeeklySlidedView:
            if indexPath.item == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThisWeekCell.cellIdentifier, for: indexPath) as? ThisWeekCell else { return UICollectionViewCell() }
                cell.configureCell(articleData: articleCardData)
                cell.delegate = self
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NextWeekCell.cellIdentifier, for: indexPath) as? NextWeekCell else { return UICollectionViewCell() }
                cell.configureCell(articleData: articleCardData)
                return cell
            }
        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - SavedArticleCellDelegate

extension HomeViewController: SavedArticleCellDelegate {
    func articleDidTap(articleID: Int?) {
        print("🎃🎃🎃🎃🎃🎃🎃🎃🎃🎃🎃🎃")
        print("아티클 아이디가 이거란 말이요 \(articleID)")
        print("🎃🎃🎃🎃🎃🎃🎃🎃🎃🎃🎃🎃")
        let articleViewController = HomeArticleViewController(articleID: articleID)
        self.navigationController?.pushViewController(articleViewController, animated: true)
    }
}

extension HomeViewController: ThisWeekCellDelegate {
    func thisWeekCardImageDidTap(articleID: Int?) {
        pushToArticleViewController()
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
        HomeAPI.shared.patchArticleCheck() { result in
            guard self.validateResult(result) != nil else { return }
        }
    }
    
    func requestAllArticleAPI() {
        HomeAPI.shared.getAllArticle() { result in
            guard let result = self.validateResult(result) as? [HomeArticleListResult] else { return }
            self.articleAllData = result
        }
    }
}
