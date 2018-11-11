//
//  CardRotateLayout.swift
//  Raccoon
//
//  Created by thekan on 08/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import UIKit

class CardRotateLayout: UICollectionViewLayout {
    
    var interCardSpacing: CGFloat = 35 {
        didSet { invalidateLayout() }
    }
    
    var cardSize: CGSize = .zero {
        didSet { invalidateLayout() }
    }
    
    var visibleCardCount: Int = 3 {
        didSet { invalidateLayout() }
    }
    
    var minimumCardScale: CGFloat = 0.7 {
        didSet { invalidateLayout() }
    }
    
    var scrollOffset: CGFloat {
        return CGFloat(Int(contentOffset.x) % Int(collectionView.bounds.width))
    }
    
    var scrollProgress: CGFloat {
        return scrollOffset / collectionView.bounds.width
    }
    
    override var collectionView: UICollectionView {
        return super.collectionView!
    }
    
    override var collectionViewContentSize: CGSize {
        let width = collectionView.bounds.width * CGFloat(numberOfItems)
        return CGSize(width: width, height: collectionView.bounds.height)
    }
    
    var numberOfItems: Int {
        let numberOfSections = collectionView.numberOfSections
        if numberOfSections > 0 {
            return collectionView.numberOfItems(inSection: 0)
        } else {
            return 0
        }
    }
    
    var contentOffset: CGPoint {
        return collectionView.contentOffset
    }
    
    var currentIndex: Int {
        let index = Int(contentOffset.x) / Int(collectionView.bounds.width)
        return max(index, 0)
    }
    
    override func prepare() {
        super.prepare()
        moveToContentOffset(at: numberOfItems - 1)
    }
    
    private func moveToContentOffset(at index: Int) {
        guard index >= 0, index < numberOfItems else {
            return
        }
        let spacing = collectionViewContentSize.width / cardSize.width
        let xOffset = spacing * CGFloat(index)
        collectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: false)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let visibleIndexPaths = getVisibleAttributes()
        var attributesList: [UICollectionViewLayoutAttributes] = []
        
        for indexPath in visibleIndexPaths {
            guard let attributes = layoutAttributesForItem(at: indexPath) else {
                break
            }
            attributesList.append(attributes)
        }
        return attributesList
    }
    
    private func getVisibleAttributes() -> [IndexPath] {
        let minVisibleIndex = max(currentIndex - visibleCardCount + 1, 0)
        let maxVisibleIndex = max(min(numberOfItems - 1, currentIndex + 1), minVisibleIndex)
        let visibleIndexPaths = (minVisibleIndex ... maxVisibleIndex)
            .map { IndexPath(item: $0, section: 0) }
        return visibleIndexPaths
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard indexPath.item >= 0, indexPath.item < numberOfItems else {
            return nil
        }
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.size = cardSize
        attributes.center.x = collectionView.center.x + (CGFloat(indexPath.item * 10))
        return attributes
    }
}
