//
//  PictureViewModel.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation

protocol PictureViewModelInputs {
    /// Открыть картинку
    func openPicture()
    /// Установить/снять статус избранного
    func changeFavoriteStatus()
}

protocol PictureViewModelOutputs {
    /// Картинка в избранных
    var isFavorite: Bool { get }
    /// ID картинки
    var id: Int { get }
    /// Ссылка на картинку
    var imageUrl: String { get }
    /// Имя фотографа
    var photographerName: String { get }
    /// Усредненный цвет фото
    var avgColorHex: String { get }
}

protocol PictureViewModelType: AnyObject {
    var inputs: PictureViewModelInputs { get }
    var outputs: PictureViewModelOutputs { get }
}

final class PictureViewModel: PictureViewModelType, PictureViewModelInputs, PictureViewModelOutputs {
    
    private var picture: Picture
    private weak var handlers: PicturesHandlers?
    
    var inputs: PictureViewModelInputs { return self }
    var outputs: PictureViewModelOutputs { return self }
    
    init(picture: Picture, handlers: PicturesHandlers) {
        self.picture = picture
        self.handlers = handlers
    }
    
    // MARK: Inputs
    
    /// Открыть картинку
    func openPicture() {
        handlers?.selectPicture(picture: picture)
    }
    /// Установить/снять статус избранного
    func changeFavoriteStatus() {
        picture.isFavorite = !(picture.isFavorite ?? false)
        handlers?.setFavorite(picture: picture)
    }
    
    // MARK: Outputs
    
    /// Картинка в избранных
    var isFavorite: Bool {
        return picture.isFavorite ?? false
    }
    /// ID картинки
    var id: Int {
        return picture.id
    }
    /// Ссылка на картинку
    var imageUrl: String {
        return picture.src.tiny
    }
    /// Имя фотографа
    var photographerName: String {
        return picture.photographer
    }
    /// Усредненный цвет фото
    var avgColorHex: String {
        return picture.avgColor
    }
}
