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
    
    private let viewModel: TicketViewModel
    
    //MARK: - UI Components
    
    let rootView = TicketSuccessView()
    
    //MARK: - Life Cycle
    
    init(viewModel: TicketViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        viewModel.toggleMode.value = .card
        viewModel.displayMode.value = .card
        let ticketViewController = TicketViewController(viewModel: viewModel, animatinoManager: AnimationManager(), ticketNetworkManager: TicketAPI())
        
        
        self.navigationController?.pushViewController(ticketViewController, animated: true)
    }
}

extension TicketSuccessViewController {
    func dataBind(imageURL: String) {
        rootView.cardImageView.kfSetImage(url: imageURL)
    }
}
