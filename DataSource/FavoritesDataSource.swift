//
//  FavoritesDataSource.swift
//  PicSplash
//
//  Created by Sergio Lechini on 02.09.2021.
//

import Foundation

protocol FavoritesDataSource {
    func getFavorite(pictureID: Int) -> Bool
    func setFavorite(pictureID: Int)
    func deleteFavorite(pictureID: Int)
    func getAllFavorites() -> [Int]
}
