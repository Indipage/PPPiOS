//
//  TicketViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

final class TicketViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let viewModel: TicketViewModel
    private let animatinoManager: AnimationManager
    private let ticketNetworkManager: TicketAPI
    
    init(
        viewModel: TicketViewModel,
        animatinoManager: AnimationManager,
        ticketNetworkManager: TicketAPI
    ) {
        self.viewModel = viewModel
        self.animatinoManager = animatinoManager
        self.ticketNetworkManager =  ticketNetworkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Components
    
    let rootView = TicketView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        delegate()
        target()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        requestTicketAPI()
        requestTicketCardAPI()
    }
    
    //MARK: - Custom Method
    
    private func target() {
        rootView.ticketToggleView.ticketToggleButton.addTarget(self, action: #selector(ticketToggleButtonDidTap), for: .touchUpInside)
        rootView.ticketToggleView.cardToggleButton.addTarget(self, action: #selector(cardToggleButtonDidTap), for: .touchUpInside)
    }
    
    private func delegate() {
        rootView.ticketView.ticketCollectionView.delegate = self
        rootView.ticketView.ticketCollectionView.dataSource = self
        
        rootView.cardView.ticketCardCollectionView.delegate = self
        rootView.cardView.ticketCardCollectionView.dataSource = self
    }
    
    private func bind() {
        viewModel.displayMode.observe(on: self) { DisplayModel in
            self.updateSelectedView(DisplayModel)
            self.updateToggleView(DisplayModel)
        }
    }
    
    func updateSelectedView(_ displayMode: DisplayMode) {
        switch displayMode {
        case .ticket:
            let isHidden = viewModel.checkTicketEmptyView()
            rootView.ticketView.isHidden = false
            rootView.cardView.isHidden = true
            rootView.ticketView.noTicketView.isHidden = !isHidden
            rootView.ticketView.ticketCollectionView.isHidden = isHidden
        case .card:
            let isHidden = viewModel.checkCardEmptyView()
            rootView.ticketView.isHidden = true
            rootView.cardView.isHidden = false
            rootView.cardView.noTicketCardView.isHidden = !isHidden
            rootView.cardView.ticketCardCollectionView.isHidden = isHidden
            rootView.cardView.cardImageView.isHidden = isHidden
        }
    }
    
    func updateToggleView(_ displayMode: DisplayMode) {
        switch displayMode {
        case .ticket:
            break
        case .card:
            rootView.ticketToggleView.toggleButton.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.top.trailing.bottom.equalToSuperview().inset(3.adjusted)
                $0.width.equalTo(155.adjusted)
            }
        }
    }
    
    //MARK: - Action Method
    
    @objc func ticketToggleButtonDidTap() {
        viewModel.ticketToggleButtonDidTap()
        let toggleView = rootView.ticketToggleView
        requestTicketAPI()
        
        animatinoManager.ticketToggleButtonAnimate (
            targetView: toggleView.toggleButton,
            translationX: viewModel.moveBy(),
            selectedLabel: toggleView.ticketLabel,
            unSelectedLable: toggleView.cardLabel
        )
    }
    
    @objc func cardToggleButtonDidTap() {
        let toggleView = rootView.ticketToggleView
        viewModel.cardToggleButtonDidTap()
        requestTicketCardAPI()
        
        animatinoManager.ticketToggleButtonAnimate (
            targetView: toggleView.toggleButton,
            translationX: viewModel.moveBy(),
            selectedLabel: toggleView.cardLabel,
            unSelectedLable: toggleView.ticketLabel)
    }
}

//MARK: - UICollectionViewDelegate

extension TicketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            return CGSize(width: Size.width, height: 247.adjusted)
        case rootView.cardView.ticketCardCollectionView:
            return CGSize(width: 68.adjusted, height: 108.adjusted)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            return 25.adjusted
        case rootView.cardView.ticketCardCollectionView:
            return 15
        default:
            return 0
        }
    }
}

//MARK: - UICollectionViewDataSource

extension TicketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            return viewModel.ticketData.count
        case rootView.cardView.ticketCardCollectionView:
            return viewModel.cardData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCollectionViewCell.cellIdentifier, for: indexPath) as? TicketCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(ticket: viewModel.ticketData[indexPath.item], point: cell.center)
            cell.delegate = self
            return cell
        case rootView.cardView.ticketCardCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCardCollectionViewCell.cellIdentifier, for: indexPath) as? TicketCardCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            cell.configureCell(card: viewModel.cardData[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - TicketCardDelegate

extension TicketViewController: TicketCardDelegate {
    func cardImageButtonDidTap(image: UIImage?) {
        rootView.cardView.cardImageView.image = image
    }
}

//MARK: - TicketDelegate

extension TicketViewController: TicketDelegate {
    func ticketImageDidSwapped(spaceID: Int?) {
        pushToQRChecktView(spaceID: spaceID)
    }
}

//MARK: - TicketViewController

extension TicketViewController {
    private func pushToQRChecktView(spaceID: Int?) {
        let qrcheckViewController = TicketCheckQRCodeViewController(spaceID: spaceID!)
        self.navigationController?.pushViewController(qrcheckViewController, animated: true)
    }
    
    private func requestTicketAPI() {
        ticketNetworkManager.getTotalTicket() { result in
            guard let result = self.validateResult(result) as? [TicketResult] else {
                return
            }
            self.viewModel.ticketData = result
            self.rootView.ticketView.ticketCollectionView.reloadData()
        }
    }
    
    private func requestTicketCardAPI() {
        ticketNetworkManager.getTotalCard() { result in
            guard let result = self.validateResult(result) as? [TicketCardResult] else {
                return
            }
            self.viewModel.cardData = result
            if !self.viewModel.cardData.isEmpty {
                self.rootView.cardView.cardImageView.kfSetImage(url: self.viewModel.cardData[0].imageURL)
            }
            self.rootView.cardView.ticketCardCollectionView.reloadData()
        }
    }
}
