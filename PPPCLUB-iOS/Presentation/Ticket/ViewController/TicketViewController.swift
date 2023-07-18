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
        }
    }
    
    private var cardData: [TicketCardResult] = [] {
        didSet {
            rootView.cardView.ticketCardCollectionView.reloadData()
        }
    }
    
    //MARK: - UI Components
    
    lazy var rootView = TicketView()
    
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
        
        showSelectedView()
        requestTicketAPI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.hidesBottomBarWhenPushed = true
        
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
            ticketToggleButtonAnimate(
                targetView: toggleView.toggleButton,
                translationX: nil,
                selectedLabel: toggleView.ticketLabel,
                unSelectedLable: toggleView.cardLabel
            )
        } else {
            ticketToggleButtonAnimate(
                targetView: toggleView.toggleButton,
                translationX: -158,
                selectedLabel: toggleView.ticketLabel,
                unSelectedLable: toggleView.cardLabel
            )
        }
    }
    
    @objc func cardToggleButtonDidTap() {
        let toggleView = rootView.ticketToggleView
        requestCardAPI()
        if toggleMode {
            ticketToggleButtonAnimate(
                targetView: toggleView.toggleButton,
                translationX: 158,
                selectedLabel: toggleView.cardLabel,
                unSelectedLable: toggleView.ticketLabel
            )
        } else {
            ticketToggleButtonAnimate(
                targetView: toggleView.toggleButton,
                translationX: nil,
                selectedLabel: toggleView.cardLabel,
                unSelectedLable: toggleView.ticketLabel
            )
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            return 0
        case rootView.cardView.ticketCardCollectionView:
            return 0
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
            cell.configureCell(card: cardData[indexPath.item])
            cell.delegate = self
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
    func ticketImageDidSwapped(spaceID: Int) {
        pushToQRChecktView(spaceID: spaceID)
    }
}

//MARK: - TicketViewController

extension TicketViewController {
    private func pushToQRChecktView(spaceID: Int) {
        let qrcheckViewController = TicketCheckQRCodeViewController(spaceID: spaceID)
        self.navigationController?.pushViewController(qrcheckViewController, animated: true)
    }
    
    private func isEmptyView() {
        if ticketData.count == 0 {
            rootView.ticketView.noTicketView.isHidden = false
            rootView.ticketView.ticketCollectionView.isHidden = true
        }
        
        if cardData.count == 0 {
            rootView.cardView.noTicketCardView.isHidden = false
            rootView.cardView.ticketCardCollectionView.isHidden = true
            rootView.cardView.cardImageView.isHidden = true
        }
    }
    
    private func showSelectedView() {
        rootView.ticketToggleView.ticketToggleButton.isEnabled = displayMode
        rootView.ticketToggleView.cardToggleButton.isEnabled = !displayMode
        rootView.ticketView.isHidden = displayMode
        rootView.cardView.isHidden = !displayMode
        
        displayMode.toggle()
    }
    
    private func requestTicketAPI() {
        TicketAPI.shared.getTotalTicket() { result in
            guard let result = self.validateResult(result) as? [TicketResult] else {
                return
            }
            self.ticketData = result
            self.isEmptyView()
        }
    }
    
    private func requestCardAPI() {
        TicketAPI.shared.getTotalCard() { result in
            guard let result = self.validateResult(result) as? [TicketCardResult] else {
                return
            }
            self.cardData = result
            self.isEmptyView()
        }
    }
    
    
    private func ticketToggleButtonAnimate(
        targetView: UIView,
        translationX: CGFloat?,
        selectedLabel: UILabel,
        unSelectedLable: UILabel) {
            let transform: CGAffineTransform
            if let translationX {
                transform = CGAffineTransform(translationX: translationX.adjusted, y: 0)
            } else {
                transform = .identity
            }
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    targetView.transform = transform
                    selectedLabel.textColor = .pppWhite
                    unSelectedLable.textColor = .pppGrey4
                }, completion: { _ in
                    self.showSelectedView()
                }
            )
        }
}

