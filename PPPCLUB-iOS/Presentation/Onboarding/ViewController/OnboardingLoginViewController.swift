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
    
    private let loginView = OnboardingLoginView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    //MARK: - Custom Method
    
    
    private func setUI(){
        
    }
    
    private func setLayout(){
        
    }
    
    //MARK: - Action Method
    
}
