//
//  PicturesPresenterMock.swift
//  PicSplashTests
//
//  Created by Sergio Lechini on 06.09.2021.
//

@testable import PicSplash
import Foundation

final class PicturesPresenterMock {
    var pictures: [Picture] = []
    var completionLoading: (()->())?
}

extension PicturesPresenterMock: PicturesPresentationLogic {
    /// Загрузить картинки
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPictures(picturesObjects: [Picture]) {
        pictures = picturesObjects
        completionLoading?()
    }
    /// Загрузить картинки постранично
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPicturesFromPage(picturesObjects: [Picture]) {
        pictures.append(contentsOf: picturesObjects)
        completionLoading?()
    }
}
