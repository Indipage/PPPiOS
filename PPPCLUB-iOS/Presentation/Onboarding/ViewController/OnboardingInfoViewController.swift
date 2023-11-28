//
//  OnboardingViewController.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 10/30/23.
//

import UIKit

import SnapKit
import Then

class OnboardingInfoViewController: UIViewController {
    
    //MARK: - Properties
    private var infoData = OnboardingInfoModel.mockDummy() {
        didSet {
            rootView.onboardingInfoCollectionView.reloadData()
        }
    }
    
    //MARK: - UI Components
    
    private let rootView = OnboardingInfoView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate()
        target()
        
    }
    
    //MARK: - Custom Method
    
    private func delegate() {
        rootView.onboardingInfoCollectionView.delegate = self
        rootView.onboardingInfoCollectionView.dataSource = self
    }
    
    //MARK: - Action Method
    private func target() {
        rootView.welcomeButton.addTarget(self, action: #selector(welcomeBtnTap), for: .touchUpInside)
    }
    
    @objc
    private func welcomeBtnTap() {
        let tbc = PPPTabBarController()
        UIApplication.shared.changeRootViewController(tbc)
    }
}

extension OnboardingInfoViewController : UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / rootView.frame.width)
        
        if(page < OnboardingInfoModel.mockDummy().count-1){
            rootView.pageControl.currentPage = page
            rootView.pageControl.isHidden = false
            rootView.welcomeButton.isHidden = true
        }
        else {
            rootView.pageControl.isHidden = true
            rootView.welcomeButton.isHidden = false
        }
      }
}

extension OnboardingInfoViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingInfoCollectionViewCell.cellIdentifier, for: indexPath) as? OnboardingInfoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.dataBind(tag: indexPath.item, infoData[indexPath.item])
        return cell
    }
}

extension OnboardingInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        return screenSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
