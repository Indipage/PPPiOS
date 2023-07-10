//
//  DetailViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/08.
//

import UIKit

import SnapKit
import Then

final class DetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    private lazy var dummy = Tag.dummy()
    
    // MARK: - UI Components
    
    private let detailView = DetailView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        target()
        register()
        delegate()
        
        style()
        hieararchy()
        layout()
    }
    
    // MARK: - Custom Method

    private func target() {}

    private func register() {
        detailView.detailTopView.tagCollectionView.register(DetailTagCollectionViewCell.self,
                                                            forCellWithReuseIdentifier: DetailTagCollectionViewCell.cellIdentifier)
        detailView.ownerView.bookCollectionView.register(DetailBookCollectionViewCell.self,
                                                         forCellWithReuseIdentifier: DetailBookCollectionViewCell.cellIdentifier)
    }

    private func delegate() {
        detailView.detailTopView.tagCollectionView.dataSource = self
        detailView.detailTopView.tagCollectionView.delegate = self
        detailView.ownerView.bookCollectionView.dataSource = self
        detailView.ownerView.bookCollectionView.delegate = self
    }

    private func style() {
        view.backgroundColor = .white
        
        detailView.do {
            $0.contentInsetAdjustmentBehavior = .never
        }
    }

    private func hieararchy() {
        view.addSubview(detailView)
    }

    private func layout() {
        detailView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(-1)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case detailView.detailTopView.tagCollectionView:
            return dummy.tagList.count
        case detailView.ownerView.bookCollectionView:
            return 3
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case detailView.detailTopView.tagCollectionView:
            guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailTagCollectionViewCell.cellIdentifier,
                                                                   for: indexPath) as? DetailTagCollectionViewCell else { return UICollectionViewCell() }
            tagCell.configureCell(text: dummy.tagList[indexPath.row])
            return tagCell
            
        case detailView.ownerView.bookCollectionView:
            guard let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailBookCollectionViewCell.cellIdentifier,
                                                                    for: indexPath) as? DetailBookCollectionViewCell else { return UICollectionViewCell() }
            bookCell.configureCell(image: UIImage(systemName: "books.vertical.fill")!)
            return bookCell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case detailView.detailTopView.tagCollectionView:
            return 3
        case detailView.ownerView.bookCollectionView:
            return 32
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case detailView.detailTopView.tagCollectionView:
            let label: UILabel = UILabel()
            label.text = dummy.tagList[indexPath.row]
            return CGSize(width: Int(label.intrinsicContentSize.width) , height: 18)
            
        case detailView.ownerView.bookCollectionView:
            let bookWidth = (collectionView.frame.width - 64) / 3
            return CGSize(width: bookWidth ,
                          height: bookWidth * 1.5 )
            
        default:
            return CGSize()
        }
    }
}
