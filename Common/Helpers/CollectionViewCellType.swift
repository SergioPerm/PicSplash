//
//  CollectionViewCellType.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import UIKit

protocol CollectionViewCellType: UICollectionViewCell {
    static var identifier: String { get }
    static func register(_ collectionView: UICollectionView)
    static func reuse(_ collectionView: UICollectionView, for indexPath: IndexPath) -> Self
}

extension CollectionViewCellType {
    static var identifier: String {
        String(describing: self)
    }
    
    static func register(_ collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: identifier)
    }
    
    static func registerXib(_ collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: identifier,
                                      bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    static func reuse(_ collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Self
    }
}
