//
//  PicturesInteractor.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation

/// Протокол для работы с PicturesInteractor
protocol PicturesBusinessLogic {
    /// Загрузить картинки
    func loadPictures()
    /// Загрузить картинки постранично
    func loadPicturesWithPaging()
    /// Загрузить картинку по запросу
    /// - Parameter queryString: строка запроса
    func loadPicturesByQuery(queryString: String)
    /// Загрузить картинку по запросу постранично
    /// - Parameter queryString: строка запроса
    func loadPicturesByQueryWithPaging(queryString: String)
    /// Метод для изменения статуса избранного у картинки, в переданной картинке уже должен быть установлен новый статус избранного
    /// - Parameter picture: объект Pictire
    func changeFavoriteStatus(picture: Picture)
}

final class PicturesInteractor {
    weak var presenter: PicturesPresentationLogic?
    
    private let favoriteDataSource: FavoritesDataSource
    private let networkAPI: PicturesNetworking
    
    private var favoritesPics: [Picture] = []
    
    // MARK: Paging
    private var currentPagesCount: Int = 0
    private let maxItemsInPage: Int = 14
    
    init(dataSource: FavoritesDataSource, networkAPI: PicturesNetworking) {
        self.favoriteDataSource = dataSource
        self.networkAPI = networkAPI
        setup()
    }
}

// MARK: Private methods
private extension PicturesInteractor {
    func setup() {
        favoritesPics = favoriteDataSource.getAllFavorites()
    }
    
    func appendFavoriteData(for pictures: [Picture]) -> [Picture] {
        let pics: [Picture] = pictures.map {
            var pic = $0
            if let _ = self.favoritesPics.first(where: { favoritePic in
                pic == favoritePic
            }) {
                pic.isFavorite = true
            }
            
            return pic
        }
        
        return pics
    }
}

// MARK: MenuBusinessLogic
extension PicturesInteractor: PicturesBusinessLogic {
    /// Загрузить картинки
    func loadPictures() {
        currentPagesCount = 0
                        
        networkAPI.getPictures(page: 1, perPage: maxItemsInPage).then { [weak self] response in
            guard let `self` = self else { return }
            self.currentPagesCount += 1
                                
            self.presenter?.loadPictures(picturesObjects: self.appendFavoriteData(for: response.photos))
        }.catch { error in
            print("error")
        }
    }
    
    /// Загрузить картинки постранично
    func loadPicturesWithPaging() {
        let newPage = currentPagesCount + 1
        
        networkAPI.getPictures(page: newPage, perPage: maxItemsInPage).then { [weak self] response in
            guard let `self` = self else { return }
            self.currentPagesCount += 1
            
            self.presenter?.loadPicturesFromPage(picturesObjects: self.appendFavoriteData(for: response.photos))
        }.catch { error in
            print("error")
        }
    }
    
    /// Загрузить картинку по запросу
    /// - Parameter queryString: строка запроса
    func loadPicturesByQuery(queryString: String) {
        currentPagesCount = 0
        
        networkAPI.getPicturesByQuery(queryString: queryString, page: 1, perPage: maxItemsInPage).then { [weak self] response in
            guard let `self` = self else { return }
            self.currentPagesCount += 1
            
            self.presenter?.loadPictures(picturesObjects: self.appendFavoriteData(for: response.photos))
        }.catch { error in
            print("error")
        }
    }
    
    /// Загрузить картинку по запросу постранично
    /// - Parameter queryString: строка запроса
    func loadPicturesByQueryWithPaging(queryString: String) {
        let newPage = currentPagesCount + 1
        
        networkAPI.getPicturesByQuery(queryString: queryString, page: newPage, perPage: maxItemsInPage).then { [weak self] response in
            guard let `self` = self else { return }
            self.currentPagesCount += 1
            
            self.presenter?.loadPicturesFromPage(picturesObjects: self.appendFavoriteData(for: response.photos))
        }.catch { error in
            print("error")
        }
    }
    
    /// Метод для изменения статуса избранного у картинки, в переданной картинке уже должен быть установлен новый статус избранного
    /// - Parameter picture: объект Pictire
    func changeFavoriteStatus(picture: Picture) {
        if picture.isFavorite ?? false {
            favoriteDataSource.setFavorite(picture: picture)
        } else {
            favoriteDataSource.deleteFavorite(pictureID: picture.id)
        }
    }
}
