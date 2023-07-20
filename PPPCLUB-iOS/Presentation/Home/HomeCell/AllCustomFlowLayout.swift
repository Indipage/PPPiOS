
//  allCustomFlowLayout.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/20.


import UIKit

class AllCustomFlowLayout: UICollectionViewFlowLayout {
    
    private var sideItemScale: CGFloat = 0.915
    
    override func prepare() {
        super.prepare()
        collectionViewSpeed()
    }
    
    private func collectionViewSpeed() {
       guard let collectionView = collectionView else { return }
       if collectionView.decelerationRate != .fast {
         collectionView.decelerationRate = .fast
       }
     }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)?.compactMap { self.collectionVIewTransform($0) }
    }
    
    private func collectionVIewTransform(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        guard let collectionView = self.collectionView else { return attributes }
        
        let contentOffsetX = collectionView.contentOffset.x
        let normalizedCenter = attributes.center.x - contentOffsetX
        
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionView.center.x - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance) / maxDistance
        
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(scale * 10)
        
        return attributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView,
              collectionView.isPagingEnabled == false,
              let layoutAttributes = self.layoutAttributesForElements(in: collectionView.bounds) else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
        
        let midSide = collectionView.bounds.size.width / 2
        let proposedContentOffsetCenter = proposedContentOffset.x + midSide
        
        let closest = layoutAttributes.min {
            abs($0.center.x - proposedContentOffsetCenter) < abs($1.center.x - proposedContentOffsetCenter)
        } ?? UICollectionViewLayoutAttributes()
        
        let targetContentOffset = CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
        
        return targetContentOffset
    }
}

