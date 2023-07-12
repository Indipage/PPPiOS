//
//  BookmarkViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

final class TicketViewController: BaseViewController {
    
    //MARK: - Properties
    
    var displayMode: Bool = true
    private var isEmpty: Bool = true
    private var ticketMockData = TicketModel.mockDummy()
    private var cardMockData = TicketCardModel.mockDummy()
    
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
        
        style()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        isEmptyView()
    }
    
    //MARK: - Custom Method
    
    private func target() {
        rootView.displayModeButton.addTarget(self, action: #selector(displayModeButtonDidTap), for: .touchUpInside)
    }
    
    private func delegate() {
        rootView.ticketView.ticketCollectionView.delegate = self
        rootView.ticketView.ticketCollectionView.dataSource = self
        
        rootView.cardView.ticketCardCollectionView.delegate = self
        rootView.cardView.ticketCardCollectionView.dataSource = self
    }
    
    private func style() {
        rootView.cardView.isHidden = displayMode
        rootView.ticketView.isHidden = !displayMode
    }
    
    //MARK: - Action Method
    
    @objc func displayModeButtonDidTap() {
        rootView.cardView.isHidden.toggle()
        rootView.ticketView.isHidden.toggle()
    }
}

//MARK: - UICollectionViewDelegate

extension TicketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            return CGSize(width: 320, height: 247)
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
            return ticketMockData.count
        case rootView.cardView.ticketCardCollectionView:
            return cardMockData.count
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
            cell.configureCell(ticket: ticketMockData[indexPath.item])
            cell.delegate = self
            return cell
        case rootView.cardView.ticketCardCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCardCollectionViewCell.cellIdentifier, for: indexPath) as? TicketCardCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            cell.configureCell(card: cardMockData[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - TicketCardDelegate

extension TicketViewController: TicketCardDelegate {
    func cardImageButtonDidTap() {
        print("버튼이 눌렷습니다!")
    }
}

//MARK: - TicketDelegate

extension TicketViewController: TicketDelegate {
    func ticketImageDidSwapped() {
        pushToQRChecktView()
    }
}

extension TicketViewController {
    func pushToQRChecktView() {
        let qrcheckViewController = TicketCheckQRCodeViewController(qrManager: QRManager())
        self.navigationController?.pushViewController(qrcheckViewController, animated: true)
    }
    
    func isEmptyView() {
        if ticketMockData.isEmpty {
            rootView.ticketView.noTicketView.isHidden = false
            rootView.ticketView.ticketCollectionView.isHidden = true
        }
        
        if cardMockData.isEmpty {
            rootView.cardView.noTicketCardView.isHidden = false
            rootView.cardView.ticketCardCollectionView.isHidden = true
            rootView.cardView.cardImageView.isHidden = true
        }
    }
}
