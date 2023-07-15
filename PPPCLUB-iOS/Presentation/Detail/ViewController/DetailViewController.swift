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
    private lazy var bookDummy = DetailBoolModel.dummy()
    private var currentIndex: Int? = 1
    
    // MARK: - UI Components
    
    private let detailView = DetailView()
    
    // MARK: - Life Cycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
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

    private func target() {
        detailView.detailTopView.saveButton.addTarget(self, action: #selector(didTouchedSaveButton), for: .touchUpInside)
        detailView.detailTopView.backButton.addTarget(self, action: #selector(didTouchedBackButton), for: .touchUpInside)
        detailView.articleRequestView.requestButton.addTarget(self, action: #selector(didTouchedRequestButton), for: .touchUpInside)
    }

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
    
    @objc
    private func didTouchedSaveButton() {
        detailView.detailTopView.saveButton.isSelected.toggle()
    }
    
    @objc func didTouchedRequestButton() {
        detailView.articleRequestView.requestButton.isSelected.toggle()
        if detailView.articleRequestView.requestButton.isSelected {
            detailView.articleRequestView.requestButton.backgroundColor = .pppMainPurple
        } else {
            detailView.articleRequestView.requestButton.backgroundColor = .pppBlack
        }
    }
    
    @objc
    func didTouchedBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case detailView.detailTopView.tagCollectionView:
            return dummy.tagList.count
        case detailView.ownerView.bookCollectionView:
            return self.bookDummy.image.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case detailView.detailTopView.tagCollectionView:
            guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailTagCollectionViewCell.cellIdentifier,
                                                                   for: indexPath) as? DetailTagCollectionViewCell else { return UICollectionViewCell() }
            tagCell.configureCell(text: dummy.tagList[indexPath.row])
            tagCell.tagView.tagLabel.asColor(targetString: "#", color: .pppMainLightGreen)
            return tagCell
            
        case detailView.ownerView.bookCollectionView:
            guard let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailBookCollectionViewCell.cellIdentifier,
                                                                    for: indexPath) as? DetailBookCollectionViewCell else { return UICollectionViewCell() }
            bookCell.configureCell(image: bookDummy.image[indexPath.row], isCenter: indexPath.row == currentIndex)
            return bookCell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case detailView.detailTopView.tagCollectionView:
            return 8
        case detailView.ownerView.bookCollectionView:
            return 32
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case detailView.detailTopView.tagCollectionView:
            let label: UILabel = UILabel()
            label.text = dummy.tagList[indexPath.row]
            return CGSize(width: Int(label.intrinsicContentSize.width) + 24 , height: 34)
            
        case detailView.ownerView.bookCollectionView:
            return CGSize(width: 116,
                          height: 156 )
            
        default:
            return CGSize()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left,
                                              y: scrollView.contentInset.top)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrolledOffset = scrollView.contentOffset.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = Int(round(scrolledOffset / cellWidth))
        currentIndex = index
        detailView.ownerView.bookCollectionView.reloadData()
    }
}
