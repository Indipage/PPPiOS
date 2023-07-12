//
//  TicketResultViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class TicketResultViewController: BaseViewController {
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    let rootView = TicketSuccessView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate()
        target()
        
        style()
    }
    
    //MARK: - Custom Method
    
    private func target() {
    }
    
    private func delegate() {
    }
    
    private func style() {
    }
    
    //MARK: - Action Method
}
