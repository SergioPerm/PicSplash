//
//  PicturesResponse.swift
//  PicSplash
//
//  Created by Sergio Lechini on 30.08.2021.
//

import Foundation

/// Модель ответа при запроса картинок
struct PicturesResponse: Codable {
    var page: Int
    var perPage: Int
    var photos: [Picture]
}
