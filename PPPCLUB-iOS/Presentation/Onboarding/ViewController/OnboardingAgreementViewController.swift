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
    
    private var agreementData = OnboardingAgreementModel.mockDummy()
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension OnboardingAgreementViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return agreementData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingAgreementCollectionViewCell.cellIdentifier, for: indexPath) as? OnboardingAgreementCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(tag: indexPath.item, agreementData[indexPath.item])
        cell.delegate = self
        return cell
    }
}

extension OnboardingAgreementViewController: OnboardingAgreementCollectionViewCellDelegate {
    func checkButtonDidTapped(tag: Int) {
        agreementData[tag].isSelected.toggle()
        
        if (agreementData[0].isSelected == true
            && agreementData[1].isSelected == true
            && agreementData[2].isSelected == true) {
            rootView.agreementButton.backgroundColor = .pppMainPurple
        } else {
            rootView.agreementButton.backgroundColor = .pppGrey3
        }
    }
}
