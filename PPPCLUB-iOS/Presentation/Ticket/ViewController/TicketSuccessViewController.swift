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
    
    //MARK: - Properties
    
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
        let ticketViewController = TicketViewController(
            viewModel: TicketViewModel(
                ticketUseCase: DefaultTicketUseCase(
                    displayMode: .card,
                    toggleMode: .card,
                    repository: DefaultTicketRepository()
                )
            ),
            animationManager: AnimationManager()
        )
        self.navigationController?.pushViewController(ticketViewController, animated: true)
    }
}

extension TicketSuccessViewController {
    func dataBind(imageURL: String) {
        rootView.cardImageView.kfSetImage(url: imageURL)
    }
}
