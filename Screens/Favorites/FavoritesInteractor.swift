//
//  FavoritesInteractor.swift
//  PicSplash
//
//  Created by Sergio Lechini on 02.09.2021.
//

import Foundation

/// Протокол для работы с FavoritesInteractor
protocol FavoritesBusinessLogic {
    /// Загрузить картинки
    func loadPictures()
    /// Сменить статус избранного у картинки
    /// - Parameter picture: объект картинки
    func changeFavoriteStatus(picture: Picture)
}

final class FavoritesInteractor {
    weak var presenter: FavoritesPresentationLogic?
    
    private let favoriteDataSource: FavoritesDataSource
    
    init(dataSource: FavoritesDataSource) {
        self.favoriteDataSource = dataSource
    }
}

// MARK: FavoritesBusinessLogic
extension FavoritesInteractor: FavoritesBusinessLogic {
    /// Загрузить картинки
    func loadPictures() {
        presenter?.loadPictures(picturesObjects: favoriteDataSource.getAllFavorites())
    }
    /// Сменить статус избранного у картинки
    /// - Parameter picture: объект картинки
    func changeFavoriteStatus(picture: Picture) {
        favoriteDataSource.deleteFavorite(pictureID: picture.id)
        presenter?.removePicture(pictureID: picture.id)
    }
}
