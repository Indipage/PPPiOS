//
//  TicketResultViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class TicketSuccessViewController: BaseViewController {
    
    //MARK: - UI Components
    
    let rootView = TicketSuccessView()
    
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
        rootView.cardViewButton.addTarget(self, action: #selector(cardButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc func cardButtonDidTap() {
        let ticketViewController = TicketViewController(viewModel: TicketViewModel())
        ticketViewController.toggleMode = false
        
        ticketViewController.rootView.ticketToggleView.toggleButton.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.top.trailing.bottom.equalToSuperview().inset(3)
                $0.width.equalTo(155.adjusted)
        }
        
        self.navigationController?.pushViewController(ticketViewController, animated: true)
    }
}

extension TicketSuccessViewController {
    func dataBind(imageURL: String) {
        rootView.cardImageView.kfSetImage(url: imageURL)
    }
}
