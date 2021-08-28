//
//  PicturesInteractor.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation

/// Протокол для работы с MenuInteractor
protocol PicturesBusinessLogic {
    /// Загрузить картинки
    func loadPictures()
}

final class PicturesInteractor {
    weak var presenter: PicturesPresentationLogic?
}

// MARK: MenuBusinessLogic
extension PicturesInteractor: PicturesBusinessLogic {
    /// Загрузить картинки
    func loadPictures() {
        
        var pics: [Picture] = []
        pics.append(contentsOf: [
            Picture(id: 0, photographer: "Ololoev Ivan", avg_color: "#D2FFBD", src: Source(tiny: "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280")),
            Picture(id: 0, photographer: "Ololoev Ivan", avg_color: "#D2FFBD", src: Source(tiny: "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280")),
            Picture(id: 0, photographer: "Ololoev Ivan", avg_color: "#D2FFBD", src: Source(tiny: "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280")),
            Picture(id: 0, photographer: "Ololoev Ivan", avg_color: "#D2FFBD", src: Source(tiny: "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280")),
            Picture(id: 0, photographer: "Ololoev Ivan", avg_color: "#D2FFBD", src: Source(tiny: "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280")),
            Picture(id: 0, photographer: "Ololoev Ivan", avg_color: "#D2FFBD", src: Source(tiny: "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280")),
            Picture(id: 0, photographer: "Ololoev Ivan", avg_color: "#D2FFBD", src: Source(tiny: "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280")),
            Picture(id: 0, photographer: "Ololoev Ivan", avg_color: "#D2FFBD", src: Source(tiny: "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"))
        ])
        
        presenter?.loadPictures(picturesObjects: pics)
        
    }
}
