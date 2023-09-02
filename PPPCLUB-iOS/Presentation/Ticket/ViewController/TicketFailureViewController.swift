//
//  TicketFailureViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/13.
//

import UIKit

import SnapKit
import Then

//MARK: - ExitButtomDelegate

protocol ExitButtonDelegate: AnyObject {
    func exitButtonDidTap()
}

final class TicketFailureViewController: UIViewController {
    
    //MARK: - Properties
    
    weak var delagate: ExitButtonDelegate?
    
    //MARK: - UI Components
    
    let rootView = TicketFailureView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
    }
    
    //MARK: - Custom Method
    
    private func target() {
        rootView.exitButton.addTarget(self, action: #selector(exitButtonDidTap), for: .touchUpInside)
        rootView.tryButton.addTarget(self, action: #selector(tryButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc func exitButtonDidTap() {
        self.dismiss(animated: true)
        delagate?.exitButtonDidTap()
    }
    
    @objc func tryButtonDidTap() {
        self.dismiss(animated: true)
//        QRManager.shared.start()
    }
}

