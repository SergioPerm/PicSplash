//
//  PicturesViewControllerMock.swift
//  PicSplashTests
//
//  Created by Sergio Lechini on 05.09.2021.
//

@testable import PicSplash
import Foundation

final class PicturesViewControllerMock {
    var viewModels: [PictureViewModelType] = []
}

extension PicturesViewControllerMock: PicturesDisplayLogic {
    /// Полностью перезагрузить картинки
    /// - Parameter ads: viewModels картинок
    func reloadPictures(pictures: [PictureViewModelType]) {
        viewModels = pictures
    }
    /// Добавить картинки к текущим
    /// - Parameter pictures: viewModels картинок
    func addPictures(pictures: [PictureViewModelType]) {
        viewModels.append(contentsOf: pictures)
    }
}
