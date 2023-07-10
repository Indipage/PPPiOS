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
        view.backgroundColor = .white
    
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
        detailView.detailTopView.tagCollectionView.register(DetailTagCollectionViewCell.self, forCellWithReuseIdentifier: DetailTagCollectionViewCell.cellIdentifier)
    }

    private func delegate() {
        detailView.detailTopView.tagCollectionView.dataSource = self
        detailView.detailTopView.tagCollectionView.delegate = self
    }

    private func style() {
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
        
    
    //MARK: - Action Method
    
}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {}
extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummy.tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailTagCollectionViewCell.cellIdentifier, for: indexPath) as? DetailTagCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(text: dummy.tagList[indexPath.row])
        return cell
    }
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label: UILabel = UILabel()
        label.text = dummy.tagList[indexPath.row]
        return CGSize(width: Int(label.intrinsicContentSize.width) , height: 18)
    }
}
