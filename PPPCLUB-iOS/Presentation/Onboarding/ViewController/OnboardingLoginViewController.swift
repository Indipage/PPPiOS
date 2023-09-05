//
//  OnboardingLoginViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/09/05.
//

import UIKit

import SnapKit
import Then

final class OnboardingLoginViewController : UIViewController {
    
    //MARK: - Properties
    
    
    
    //MARK: - UI Components
    
    let rootView = OnboardingLoginView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
    }
    
    //MARK: - Custom Method
    
    private func target() {
        rootView.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc private func appleLoginButtonDidTap() {
        let onboardingAgreementVC = OnboardingAgreementViewController()
        self.navigationController?.pushViewController(onboardingAgreementVC, animated: true)
    }
    
}
