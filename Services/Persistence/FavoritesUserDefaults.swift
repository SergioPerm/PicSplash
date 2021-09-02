//
//  FavoritesUserDefaults.swift
//  PicSplash
//
//  Created by Sergio Lechini on 02.09.2021.
//

import Foundation

final class FavoritesUserDefaults {
    enum Key: String, CaseIterable {
        case favorite
        func make(for pictureID: String) -> String {
            return self.rawValue + "_" + pictureID
        }
    }
    
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}

private extension FavoritesUserDefaults {
    func removeFavorite(pictureID: String) {
        Key
            .allCases
            .map { $0.make(for: pictureID) }
            .forEach { key in
                userDefaults.removeObject(forKey: key)
        }
    }
    
    func saveValue(forKey key: Key, value: Any, pictureID: String) {
        userDefaults.set(value, forKey: key.make(for: pictureID))
    }
    
    func readValue<T>(forKey key: Key, pictureID: String) -> T? {
        return userDefaults.value(forKey: key.make(for: pictureID)) as? T
    }
    
    func getAllItems(for key: Key) -> [String: Any] {
        return userDefaults.dictionaryRepresentation().filter { item in
            item.key.contains(key.rawValue)
        }
    }
}

extension FavoritesUserDefaults: FavoritesDataSource {
    func getFavorite(pictureID: Int) -> Bool {
        if let isFavorite: Bool = readValue(forKey: .favorite, pictureID: String(pictureID)) {
            return isFavorite
        }
        
        return false
    }
    
    func setFavorite(pictureID: Int) {
        saveValue(forKey: .favorite, value: pictureID, pictureID: String(pictureID))
    }
    
    func deleteFavorite(pictureID: Int) {
        removeFavorite(pictureID: String(pictureID))
    }
    
    func getAllFavorites() -> [Int] {
        return getAllItems(for: .favorite).compactMap { $0.value as? Int }
    }
}
