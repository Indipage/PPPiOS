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
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    var viewVelocity = CGPoint(x: 0, y: 0)
    
    private var gesture : UIPanGestureRecognizer!
    
    private var savedArticleData: [MySavedArticleResult] = [] {
        didSet {
            rootView.homeAllView.savedArticleCollectionView.reloadData()
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
        
        requestSavedArticleAPI()
    }
    
    // MARK: - Custom Method
    
    private func target() {
        
        gesture = UIPanGestureRecognizer(target: self,
                                         action: #selector(ticketCaseMoved(_:)))
        
        rootView.homeNavigationView.weeklyButton.addTarget(self, action: #selector(weeklyButtonTap), for: .touchUpInside)
        rootView.homeNavigationView.allButton.addTarget(self, action: #selector(allButtonTap), for: .touchUpInside)
        
    }
    
    private func delegate() {
        rootView.homeAllView.savedArticleCollectionView.delegate = self
        rootView.homeAllView.savedArticleCollectionView.dataSource = self
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
    
    @objc
    public func ticketDragAnimation() {
        
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
                    UIView.animate(withDuration: 0.4, animations: {
                        self.rootView.homeWeeklyView.ticketCoverImageView.transform = CGAffineTransform(translationX: 0, y: 600)
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
            else {
                self.ticketDragAnimation()
            }
            
        default:
            break
            
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

extension HomeViewController: SavedArticleCellDelegate {
    func articleDidTap() {
        let articleViewController = HomeArticleViewController()
        self.navigationController?.pushViewController(articleViewController, animated: true)
    }

    private func requestSavedArticleAPI() {
        MyAPI.shared.getSavedArticle() { result in
            guard let result = self.validateResult(result) as? [MySavedArticleResult] else { return }
            self.savedArticleData = result
        }
    }
}
