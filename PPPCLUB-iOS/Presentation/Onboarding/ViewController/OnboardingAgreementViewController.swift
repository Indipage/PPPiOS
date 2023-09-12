//
//  OnboardingAgreementViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/09/05.
//

import UIKit

import SnapKit
import Then
import AuthenticationServices

final class OnboardingAgreementViewController : UIViewController, ASAuthorizationControllerDelegate {
    
    
    //MARK: - Properties
    
    private var agreementData = OnboardingAgreementModel.mockDummy() {
        didSet {
            rootView.agreementCollectionView.reloadData()
        }
    }
    
    //MARK: - UI Components
    
    private let rootView = OnboardingAgreementView()
    
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
        rootView.agreementCollectionView.delegate = self
        rootView.agreementCollectionView.dataSource = self
        
        rootView.agreementHeaderView.delegate = self
    }
    
    //MARK: - Action Method
    
    private func target() {
        rootView.agreementButton.addTarget(self, action: #selector(agreementButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    private func agreementButtonDidTap() {
        print("⭐️agree")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        //            authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
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
        print(#function)
        return agreementData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingAgreementCollectionViewCell.cellIdentifier, for: indexPath) as? OnboardingAgreementCollectionViewCell else {
            return UICollectionViewCell()
            
        }
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
            rootView.agreementButton.isEnabled = true
            if agreementData[3].isSelected == true {
                rootView.agreementHeaderView.allAgreementCheckButton.isSelected = true
            } else {
                rootView.agreementHeaderView.allAgreementCheckButton.isSelected = false
            }
        } else {
            rootView.agreementHeaderView.allAgreementCheckButton.isSelected = false
            rootView.agreementButton.backgroundColor = .pppGrey3
            rootView.agreementButton.isEnabled = false
        }
    }
}

extension OnboardingAgreementViewController: OnboardingAgreementCollectionHeaderViewDelegate {
    func allAgreementCheckButtonDidTapped(_ tag: Int) {
        var check = rootView.agreementHeaderView.allAgreementCheckButton.isSelected
        for i in 0..<agreementData.count {
            agreementData[i].isSelected = check
        }
        
        if (agreementData[0].isSelected) {
            rootView.agreementButton.backgroundColor = .pppMainPurple
            rootView.agreementButton.isEnabled = true
        } else {
            rootView.agreementButton.backgroundColor = .pppGrey3
            rootView.agreementButton.isEnabled = false
        }
    }
}
