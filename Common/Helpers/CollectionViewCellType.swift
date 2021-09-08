//
//  CollectionViewCellType.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import UIKit

/// Protocol для работы с расширенным функционалом collection view cell
protocol CollectionViewCellType: UICollectionViewCell {
    /// Текущий идентификатор ячейки
    static var identifier: String { get }
    /// Зарегстрировать ячейку
    /// - Parameter collectionView: collectionView
    static func register(_ collectionView: UICollectionView)
    /// Получить ячейку с помощью метода dequeueReusableCell
    /// - Parameters:
    ///   - collectionView: для collectionView
    ///   - indexPath: для indexPath
    static func reuse(_ collectionView: UICollectionView, for indexPath: IndexPath) -> Self
}

extension CollectionViewCellType {
    /// Текущий идентификатор ячейки
    static var identifier: String {
        String(describing: self)
    }
    /// Зарегстрировать ячейку
    /// - Parameter collectionView: collectionView
    static func register(_ collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: identifier)
    }
    /// Получить ячейку с помощью метода dequeueReusableCell
    /// - Parameters:
    ///   - collectionView: для collectionView
    ///   - indexPath: для indexPath
    static func reuse(_ collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Self
    }
}
