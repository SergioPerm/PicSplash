//
//  FavoritesDataSource.swift
//  PicSplash
//
//  Created by Sergio Lechini on 02.09.2021.
//

import Foundation

protocol FavoritesDataSource: AnyObject {
    func getFavorite(pictureID: Int) -> Bool
    func setFavorite(picture: Picture)
    func deleteFavorite(pictureID: Int)
    func getAllFavorites() -> [Picture]
}
