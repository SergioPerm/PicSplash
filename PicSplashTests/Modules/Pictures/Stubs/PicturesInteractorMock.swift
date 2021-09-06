//
//  PicturesInteractorMock.swift
//  PicSplashTests
//
//  Created by Sergio Lechini on 05.09.2021.
//

@testable import PicSplash
import Foundation

final class PicturesInteractorMock {
    weak var presenter: PicturesPresentationLogic?
    
    var pictures: [Picture] = []
    var picturesForNewPage: [Picture] = []
}

extension PicturesInteractorMock: PicturesBusinessLogic {
    /// Загрузить картинки
    func loadPictures() {
        presenter?.loadPictures(picturesObjects: pictures)
    }
    /// Загрузить картинки постранично
    func loadPicturesWithPaging() {
        presenter?.loadPicturesFromPage(picturesObjects: picturesForNewPage)
    }
    /// Загрузить картинку по запросу
    /// - Parameter queryString: строка запроса
    func loadPicturesByQuery(queryString: String) {
        presenter?.loadPictures(picturesObjects: pictures)
    }
    /// Загрузить картинку по запросу постранично
    /// - Parameter queryString: строка запроса
    func loadPicturesByQueryWithPaging(queryString: String) {
        presenter?.loadPicturesFromPage(picturesObjects: picturesForNewPage)
    }
    
    func changeFavoriteStatus(picture: Picture) {
        
    }
}
