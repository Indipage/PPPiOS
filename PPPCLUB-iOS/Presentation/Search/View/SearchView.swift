//
//  SearchView.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

final class SearchView: UIView {
    
    // MARK: - Properties
    
    let placeholder: String = "지역명으로 검색해보세요 ex) 서초구"
    private lazy var attributedString = NSMutableAttributedString(string: placeholder,
                                                     attributes: [NSAttributedString.Key.font: UIFont.pppBody4 ,
                                                                  NSAttributedString.Key.foregroundColor: UIColor.pppGrey5])
        
    // MARK: - UI Components
    
    lazy var searchTableView = UITableView(frame: .zero, style: .grouped)
    lazy var searchBar = UISearchBar()
    lazy var searchHeaderView = SearchHeaderView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        searchTableView.do {
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
        }
        
        searchBar.do {
            $0.showsCancelButton = false
            $0.backgroundImage = UIImage()
            $0.searchTextField.backgroundColor = .pppGrey2
            $0.searchTextField.leftView?.tintColor = .pppGrey5
            $0.searchTextField.attributedPlaceholder = attributedString
            $0.showsCancelButton = false
        }
    }
    
    private func hierarchy() {
        self.addSubviews(searchTableView,
                         searchBar
        )
    }
    
    private func layout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
                
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.bottom.equalToSuperview()
        }
        
        searchHeaderView.snp.makeConstraints {
            $0.height.equalTo(46)
        }
    }
}
