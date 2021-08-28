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
    func setFavoriteStatus()
    /// Отменить установку статуса избранного
    func cancelSetFavorite()
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
    
    private let picture: Picture
    
    var inputs: PictureViewModelInputs { return self }
    var outputs: PictureViewModelOutputs { return self }
    
    init(picture: Picture) {
        self.picture = picture
    }
    
    // MARK: Inputs
    
    /// Открыть картинку
    func openPicture() {
        
    }
    /// Установить/снять статус избранного
    func setFavoriteStatus() {
        
    }
    /// Отменить установку статуса избранного
    func cancelSetFavorite() {
        
    }
    
    // MARK: Outputs
    
    /// Картинка в избранных
    var isFavorite: Bool {
        return false
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
        return picture.avg_color
    }
}
