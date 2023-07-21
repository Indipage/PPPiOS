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
    
    var displayMode: Bool = false
    var toggleMode: Bool = true
    
    private var ticketData: [TicketResult] = [] {
        didSet {
            rootView.ticketView.ticketCollectionView.reloadData()
            self.isEmptyView()
        }
    }
    
    private var cardData: [TicketCardResult] = [] {
        didSet {
            rootView.cardView.ticketCardCollectionView.reloadData()
            self.isEmptyView()
        }
    }
    
    //MARK: - UI Components
    
    let rootView = TicketView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate()
        target()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        requestTicketAPI()
        requestTicketCardAPI()
        showSelectedView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        displayMode.toggle()
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
    
    //MARK: - Action Method
    
    @objc func ticketToggleButtonDidTap() {
        let toggleView = rootView.ticketToggleView
        requestTicketAPI()
        if toggleMode {
            AnimationManager.shared.ticketToggleButtonAnimate (
                targetView: toggleView.toggleButton,
                translationX: nil,
                selectedLabel: toggleView.ticketLabel,
                unSelectedLable: toggleView.cardLabel) { _ in
                    self.showSelectedView()
                }
            
        } else {
            AnimationManager.shared.ticketToggleButtonAnimate (
                targetView: toggleView.toggleButton,
                translationX: -158.adjusted,
                selectedLabel: toggleView.ticketLabel,
                unSelectedLable: toggleView.cardLabel) { _ in
                    self.showSelectedView()
                }
        }
    }
    
    @objc func cardToggleButtonDidTap() {
        let toggleView = rootView.ticketToggleView
        requestTicketCardAPI()
        if toggleMode {
            AnimationManager.shared.ticketToggleButtonAnimate (
                targetView: toggleView.toggleButton,
                translationX: 158.adjusted,
                selectedLabel: toggleView.cardLabel,
                unSelectedLable: toggleView.ticketLabel) { _ in
                    self.showSelectedView()
                }
        } else {
            AnimationManager.shared.ticketToggleButtonAnimate (
                targetView: toggleView.toggleButton,
                translationX: nil,
                selectedLabel: toggleView.cardLabel,
                unSelectedLable: toggleView.ticketLabel) { _ in
                    self.showSelectedView()
                }
        }
    }
}

//MARK: - UICollectionViewDelegate

extension TicketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            return CGSize(width: Size.width, height: 247)
        case rootView.cardView.ticketCardCollectionView:
            return CGSize(width: 68, height: 108)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            return 25
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
            return ticketData.count
        case rootView.cardView.ticketCardCollectionView:
            return cardData.count
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
            cell.configureCell(ticket: ticketData[indexPath.item], point: cell.center)
            cell.delegate = self
            return cell
        case rootView.cardView.ticketCardCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCardCollectionViewCell.cellIdentifier, for: indexPath) as? TicketCardCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            cell.configureCell(card: cardData[indexPath.item])
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
    
    private func isEmptyView() {
        if ticketData.isEmpty {
            rootView.ticketView.noTicketView.isHidden = false
            rootView.ticketView.ticketCollectionView.isHidden = true
        } else {
            rootView.ticketView.noTicketView.isHidden = true
            rootView.ticketView.ticketCollectionView.isHidden = false
        }
        
        if cardData.isEmpty {
            rootView.cardView.noTicketCardView.isHidden = false
            rootView.cardView.ticketCardCollectionView.isHidden = true
            rootView.cardView.cardImageView.isHidden = true
        } else {
            rootView.cardView.noTicketCardView.isHidden = true
            rootView.cardView.ticketCardCollectionView.isHidden = false
            rootView.cardView.cardImageView.isHidden = false
        }
    }
    
    private func showSelectedView() {
        rootView.ticketView.isHidden = displayMode
        rootView.cardView.isHidden = !displayMode
        isEmptyView()
        displayMode.toggle()
    }
    
    private func requestTicketAPI() {
        TicketAPI.shared.getTotalTicket() { result in
            guard let result = self.validateResult(result) as? [TicketResult] else {
                return
            }
            self.ticketData = result
        }
    }
    
    private func requestTicketCardAPI() {
        TicketAPI.shared.getTotalCard() { result in
            guard let result = self.validateResult(result) as? [TicketCardResult] else {
                return
            }
            self.cardData = result
            if !self.cardData.isEmpty {
                self.rootView.cardView.cardImageView.kfSetImage(url: self.cardData[0].imageURL)
            }
        }
    }
}
