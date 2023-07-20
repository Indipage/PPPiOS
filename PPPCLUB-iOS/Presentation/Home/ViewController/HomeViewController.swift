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
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    var viewVelocity = CGPoint(x: 0, y: 0)
    
    private var gesture : UIPanGestureRecognizer!
    
    private var articleCardData: HomeArticleCardResult?  {
        didSet {
            self.dataBindArticleCard(articleData: articleCardData)
            self.rootView.homeWeeklyView.weeklyCollectionView.reloadData()
        }
    }
    
    private var articleSlideCheckData: HomeArticleCheckResult? {
        didSet {
            self.dataBindArticleSlideCheck(articleData: articleSlideCheckData)
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
        
        
        target()
        delegate()
        
        style()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        requestArticleCardAPI()
        requestSlideCheckAPI()
        requestAllArticleAPI()
    }
    
    // MARK: - Custom Method
    
    private func target() {
        
        gesture = UIPanGestureRecognizer(target: self,
                                         action: #selector(ticketCaseMoved(_:)))
        rootView.homeNavigationView.weeklyButton.addTarget(self, action: #selector(weeklyButtonTap), for: .touchUpInside)
        rootView.homeNavigationView.allButton.addTarget(self, action: #selector(allButtonTap), for: .touchUpInside)
        
    }
    
    private func delegate() {
        
        rootView.homeAllView.allArticleCollectionView.delegate = self
        rootView.homeAllView.allArticleCollectionView.dataSource = self
        rootView.homeWeeklyView.weeklyCollectionView.delegate = self
        rootView.homeWeeklyView.weeklyCollectionView.dataSource = self
    }
    
    private func style() {
        
        rootView.homeWeeklyView.ticketCoverImageView.do {
            $0.addGestureRecognizer(gesture)
        }
        
    }
    
    //MARK: - Action Method
    
    @objc
    func weeklyButtonTap() {
        
        rootView.homeNavigationView.weeklyButton.isSelected = true
        rootView.homeNavigationView.allButton.isSelected = false
        rootView.homeNavigationView.weeklyButton.backgroundColor = .pppMainPurple
        rootView.homeNavigationView.allButton.backgroundColor = .pppGrey2
        
        rootView.homeWeeklyView.isHidden = false
        rootView.homeAllView.isHidden = true
    }
    
    @objc
    func allButtonTap() {
        
        rootView.homeNavigationView.weeklyButton.isSelected = false
        rootView.homeNavigationView.allButton.isSelected = true
        rootView.homeNavigationView.weeklyButton.backgroundColor = .pppGrey2
        rootView.homeNavigationView.allButton.backgroundColor = .pppMainPurple
        
        rootView.homeWeeklyView.isHidden = true
        rootView.homeAllView.isHidden = false
    }
    
    
    func pushToArticleViewController() {
        
        let homeArticleVC = HomeArticleViewController()
        self.navigationController?.pushViewController(homeArticleVC, animated: true)
        
    }
    
    private func ticketDragAnimation() {
        requestPutSlideAPI()
        pushToArticleViewController()
    }
    
    @objc
    private func ticketCaseMoved(_ sender: UIPanGestureRecognizer) {
        
        viewTranslation = sender.translation(in: rootView.homeWeeklyView.ticketCoverImageView)
        viewVelocity = sender.velocity(in: rootView.homeWeeklyView.ticketCoverImageView)
        
        switch sender.state {
        case .changed:
            if abs(viewVelocity.y) > abs(viewVelocity.x) {
                
                if viewTranslation.y >= 152 {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.rootView.homeWeeklyView.ticketCoverImageView.transform = CGAffineTransform(translationX: 0, y: 600)
                        sender.state = .ended
                    }, completion: { _ in
                        self.ticketDragAnimation()
                    })
                }
                
                else if viewVelocity.y > 0 {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.rootView.homeWeeklyView.ticketCoverImageView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                    })
                }
            }
            
        case .ended:
            if viewTranslation.y < 152 {
                UIView.animate(withDuration: 0.04, animations: {
                    self.rootView.homeWeeklyView.ticketCoverImageView.transform = .identity
                })
            }
            
        default:
            break
            
        }
    }
}

//MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case rootView.homeWeeklyView.weeklyCollectionView:
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
        case rootView.homeWeeklyView.weeklyCollectionView:
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
        case rootView.homeWeeklyView.weeklyCollectionView:
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
        case rootView.homeWeeklyView.weeklyCollectionView:
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
        case rootView.homeWeeklyView.weeklyCollectionView:
            if indexPath.item == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: thisWeekCell.cellIdentifier, for: indexPath) as? thisWeekCell else { return UICollectionViewCell() }
                cell.configureCell(articleData: articleCardData)
                cell.delegate = self
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nextWeekCell.cellIdentifier, for: indexPath) as? nextWeekCell else { return UICollectionViewCell() }
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
    func articleDidTap() {
        let articleViewController = HomeArticleViewController()
        self.navigationController?.pushViewController(articleViewController, animated: true)
    }
}

extension HomeViewController: ThisWeekCellDelegate {
    func thisWeekCardImageDidTap() {
        pushToArticleViewController()
    }
}

extension HomeViewController {
    func dataBindArticleCard(articleData: HomeArticleCardResult?) {
        guard let articleData = articleData else { return }
        rootView.homeWeeklyView.cardId = articleData.id
        rootView.homeWeeklyView.thisWeekCardImage.kfSetImage(url: articleData.thumbnailUrlOfThisWeek)
        rootView.homeWeeklyView.nextWeekCardImage.kfSetImage(url: articleData.thumbnailUrlOfNextWeek)
        rootView.homeWeeklyView.cardTitleLabel.text = articleData.title
        rootView.homeWeeklyView.cardStoreNameLabel.text = articleData.spaceName
        rootView.homeWeeklyView.cardStoreOwnerLabel.text = articleData.spaceOwner
        
        rootView.homeWeeklyView.cardId = articleData.id
        rootView.homeWeeklyView.thisWeekCardImage.kfSetImage(url: articleData.thumbnailUrlOfThisWeek)
        rootView.homeWeeklyView.nextWeekCardImage.kfSetImage(url: articleData.thumbnailUrlOfNextWeek)
        rootView.homeWeeklyView.cardTitleLabel.text = articleData.title
        rootView.homeWeeklyView.cardStoreNameLabel.text = articleData.spaceName
        rootView.homeWeeklyView.cardStoreOwnerLabel.text = articleData.spaceOwner
    }
    
    func dataBindArticleSlideCheck(articleData: HomeArticleCheckResult?) {
        guard let hasSlide = articleData?.hasSlide else { return }
        rootView.homeWeeklyView.isHidden = !hasSlide
    }
    
    func requestArticleCardAPI() {
        HomeAPI.shared.getArticleCard() { result in
            guard let result = self.validateResult(result) as? HomeArticleCardResult else { return }
            self.articleCardData = result
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



