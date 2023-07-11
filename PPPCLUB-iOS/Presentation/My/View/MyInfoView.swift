//
//  MyInfoView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyInfoView: UITableView {
    
    // MARK: - Properties
    
    //MARK: - UI Components
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        register()
        
        tableStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func register() {
        self.register(MyInfoTableViewCell.self, forCellReuseIdentifier: MyInfoTableViewCell.cellIdentifier)
    }
    
    private func tableStyle() {
        self.do {
            $0.backgroundColor = .green
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
        }
    }
}
