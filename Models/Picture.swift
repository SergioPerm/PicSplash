//
//  Picture.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation

/// Модель картинки
struct Picture: Codable {
    /// Уникальный ID
    var id: Int
    /// Имя фотографа
    var photographer: String
    /// Усредненный цвет фотографии
    var avgColor: String
    /// Ресурсы фото
    var src: Source
    
    // nocodable properties
    /// Избранное фото
    var isFavorite: Bool?
}

// MARK: Equatable
extension Picture: Equatable {
    static func == (lhs: Picture, rhs: Picture) -> Bool {
        lhs.id == rhs.id
    }
}

/// Модель ресурсов фото
struct Source: Codable {
    var original: String = ""
    var large2x: String = ""
    var large: String = ""
    var medium: String = ""
    var small: String = ""
    var portrait: String = ""
    var landscape: String = ""
    var tiny: String = ""
    
    init(tiny: String) {
        self.tiny = tiny
    }
}
