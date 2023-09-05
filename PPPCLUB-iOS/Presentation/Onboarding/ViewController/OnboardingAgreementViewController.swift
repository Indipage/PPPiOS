//
//  OnboardingAgreementViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/09/05.
//

import UIKit

import SnapKit
import Then

final class OnboardingAgreementViewController : UIViewController {
    
    //MARK: - Properties
    
    private let agreementData = OnboardingAgreementModel.mockDummy()
    
    //MARK: - UI Components
    
    private let rootView = OnboardingAgreementView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate()
        
    }
    
    //MARK: - Custom Method
    
    
    private func delegate() {
        rootView.agreementCollectionView.delegate = self
        rootView.agreementCollectionView.dataSource = self
    }
    
    //MARK: - Action Method
    
}

extension OnboardingAgreementViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Size.width, height: 33)
    }
}
extension OnboardingAgreementViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return agreementData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingAgreementCollectionViewCell.cellIdentifier, for: indexPath) as? OnboardingAgreementCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(agreementData[indexPath.item])
        return cell
    }
}

