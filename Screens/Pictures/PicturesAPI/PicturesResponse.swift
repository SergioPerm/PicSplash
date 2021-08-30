//
//  PicturesResponse.swift
//  PicSplash
//
//  Created by Sergio Lechini on 30.08.2021.
//

import Foundation

struct PicturesResponse: Codable {
    var page: Int
    var perPage: Int
    var photos: [Picture]
}
