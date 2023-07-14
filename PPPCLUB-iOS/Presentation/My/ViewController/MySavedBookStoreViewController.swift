//
//  MySavedBookStoreController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MySavedBookStoreViewController: BaseViewController {
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    let rootView = MyView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate()
    }
    
    private func delegate() {
        
    }
}


