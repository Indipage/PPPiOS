//
//  allCustomFlowLayout.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/20.
//

//import UIKit
//
//class AllCustomFlowLayout: UICollectionViewFlowLayout {
//
//    private var isInit: Bool = false
//    override func prepare() {
//        super.prepare()
//        guard !isInit else { return }
//
//        guard let collectionView = self.collectionView else { return }
//
//        let collectionViewSize = collectionView?.bounds
//        itemSize = CGSize(width: 295, height: 472)
//
//        let xInset = (collectionViewSize.width - itemSize.width) / 2
//        self.sectionInset = UIEdgeInsets(top: 0, left: xInset, bottom: 0, right: xInset)
//
//        scrollDirection = .horizontal
//
//        minimumLineSpacing = 10 - (itemSize.width - itemSize.width * 0.7) /2
//
//        isInit = true
//    }
//
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
//
//}
