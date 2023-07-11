//
//  BookmarkViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

final class TicketViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var displayMode: Bool = true
    
    //MARK: - UI Components
    
    let rootView = TicketView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate()
        target()
    }
    
    private func target() {
        print(#function)
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
    
    @objc func displayModeButtonDidTap() {
        rootView.cardView.isHidden.toggle()
        rootView.ticketView.isHidden.toggle()
    }
}

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
extension TicketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            return 10
        case rootView.cardView.ticketCardCollectionView:
            return 10
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
            return cell
        case rootView.cardView.ticketCardCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCardCollectionViewCell.cellIdentifier, for: indexPath) as? TicketCardCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
}
