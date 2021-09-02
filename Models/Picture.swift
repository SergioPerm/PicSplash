//
//  Picture.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation

struct Picture: Codable {
    var id: Int
    var photographer: String
    var avgColor: String
    var src: Source
    
    // nocodable properties
    var isFavorite: Bool?
}

extension Picture: Equatable {
    static func == (lhs: Picture, rhs: Picture) -> Bool {
        lhs.id == rhs.id
    }
}

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
