//
//  PicturesDataSourceMock.swift
//  PicSplashTests
//
//  Created by Sergio Lechini on 06.09.2021.
//

@testable import PicSplash
import Foundation

final class PicturesDataSourceMock {
    var favoritesPictures: [Picture] = []
    var currentChangeFavorite: Picture?
}

extension PicturesDataSourceMock: FavoritesDataSource {
    func getFavorite(pictureID: Int) -> Bool {
        return false
    }
    
    func setFavorite(picture: Picture) {
        currentChangeFavorite = picture
    }
    
    func deleteFavorite(pictureID: Int) {
        currentChangeFavorite = nil
    }
    
    func getAllFavorites() -> [Picture] {
        return favoritesPictures
    }
}
