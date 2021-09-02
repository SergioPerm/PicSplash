//
//  FavoritesUserDefaults.swift
//  PicSplash
//
//  Created by Sergio Lechini on 02.09.2021.
//

import Foundation

final class FavoritesUserDefaults {
    let keyUD: String = "favorites_"
    let encoder: JSONEncoder = JSONEncoder()
    let decoder: JSONDecoder = JSONDecoder()
    
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}

private extension FavoritesUserDefaults {
    func removeFavorite(pictureID: String) {
        userDefaults.removeObject(forKey: keyUD + pictureID)
    }
    
    func saveValue(forKey pictureID: String, value: Data) {
        userDefaults.set(value, forKey: keyUD + pictureID)
    }
    
    func readValue<T>(forKey pictureID: String) -> T? {
        return userDefaults.value(forKey: keyUD + pictureID) as? T
    }
    
    func getAllItems() -> [String: Any] {
        return userDefaults.dictionaryRepresentation().filter { item in
            item.key.contains(keyUD)
        }
    }
}

extension FavoritesUserDefaults: FavoritesDataSource {
    func getFavorite(pictureID: Int) -> Bool {
        if let isFavorite: Bool = readValue(forKey: String(pictureID)) {
            return isFavorite
        }
        
        return false
    }
    
    func setFavorite(picture: Picture) {
        let id = String(picture.id)
        if let encoded = try? encoder.encode(picture) {
            saveValue(forKey: id, value: encoded)
        }
    }
    
    func deleteFavorite(pictureID: Int) {
        removeFavorite(pictureID: String(pictureID))
    }
    
    func getAllFavorites() -> [Picture] {
        return getAllItems().compactMap {
            if let data = $0.1 as? Data, let loadedPicture = try? decoder.decode(Picture.self, from: data) {
                return loadedPicture
            }
            return nil
        }
    }
}
