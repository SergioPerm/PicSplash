//
//  FavoritesInteractor.swift
//  PicSplash
//
//  Created by Sergio Lechini on 02.09.2021.
//

import Foundation

/// Протокол для работы с PicturesInteractor
protocol FavoritesBusinessLogic {
    /// Загрузить картинки
    func loadPictures()
    func changeFavoriteStatus(picture: Picture)
}

final class FavoritesInteractor {
    weak var presenter: FavoritesPresentationLogic?
    
    private let favoriteDataSource: FavoritesDataSource
    
    init(dataSource: FavoritesDataSource) {
        self.favoriteDataSource = dataSource
    }
}

// MARK: MenuBusinessLogic
extension FavoritesInteractor: FavoritesBusinessLogic {
    /// Загрузить картинки
    func loadPictures() {
        presenter?.loadPictures(picturesObjects: favoriteDataSource.getAllFavorites())
    }
        
    func changeFavoriteStatus(picture: Picture) {
        favoriteDataSource.deleteFavorite(pictureID: picture.id)
        presenter?.removePicture(pictureID: picture.id)
    }
}
