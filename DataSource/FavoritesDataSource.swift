//
//  FavoritesDataSource.swift
//  PicSplash
//
//  Created by Sergio Lechini on 02.09.2021.
//

import Foundation

/// Протокол для работы с хранилищем избранного
protocol FavoritesDataSource: AnyObject {
    /// Получить статус избранного
    /// - Parameter pictureID: id картинки
    func getFavorite(pictureID: Int) -> Bool
    /// Установить статус избранного
    /// - Parameter picture: объект картинки
    func setFavorite(picture: Picture)
    /// Удалить статус избранного
    /// - Parameter pictureID: id картинки
    func deleteFavorite(pictureID: Int)
    /// Получить все картинки в избранном
    func getAllFavorites() -> [Picture]
}
