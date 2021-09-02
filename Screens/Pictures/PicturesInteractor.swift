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
    func changeFavoriteStatus(for id: Int, newStatus: Bool)
}

final class PicturesInteractor {
    weak var presenter: PicturesPresentationLogic?
    
    private let favoriteDataSource: FavoritesDataSource
    private var favoritesPics: [Int] = []
    
    // MARK: Paging
    private var currentPagesCount: Int = 0
    private let maxItemsInPage: Int = 14
    
    init(dataSource: FavoritesDataSource) {
        self.favoriteDataSource = dataSource
        setup()
    }
}

// MARK: Private methods
private extension PicturesInteractor {
    func setup() {
        favoritesPics = favoriteDataSource.getAllFavorites()
    }
    
    func loadFavoriteData(for pictures: [Picture]) -> [Picture] {
        return pictures.map {
            var photo = $0
            if let _ = self.favoritesPics.first(where: { id in id == photo.id }) {
                photo.isFavorite = true
            } else {
                photo.isFavorite = false
            }
            return photo
        }
    }
}

// MARK: MenuBusinessLogic
extension PicturesInteractor: PicturesBusinessLogic {
    /// Загрузить картинки
    func loadPictures() {
        currentPagesCount = 0
        
        PicturesAPI.getPictures(page: 1, perPage: maxItemsInPage).then { [weak self] response in
            guard let `self` = self else { return }
            self.currentPagesCount += 1
                                
            self.presenter?.loadPictures(picturesObjects: self.loadFavoriteData(for: response.photos))
        }.catch { error in
            print("error")
        }
    }
    
    /// Загрузить картинки постранично
    func loadPicturesWithPaging() {
        let newPage = currentPagesCount + 1
        
        PicturesAPI.getPictures(page: newPage, perPage: maxItemsInPage).then { [weak self] response in
            guard let `self` = self else { return }
            self.currentPagesCount += 1
            
            self.presenter?.loadPicturesFromPage(picturesObjects: self.loadFavoriteData(for: response.photos))
        }.catch { error in
            print("error")
        }
    }
    
    /// Загрузить картинку по запросу
    /// - Parameter queryString: строка запроса
    func loadPicturesByQuery(queryString: String) {
        currentPagesCount = 0
        
        PicturesAPI.getPicturesByQuery(queryString: queryString, page: 1, perPage: maxItemsInPage).then { [weak self] response in
            guard let `self` = self else { return }
            self.currentPagesCount += 1
            
            self.presenter?.loadPictures(picturesObjects: self.loadFavoriteData(for: response.photos))
        }.catch { error in
            print("error")
        }
    }
    
    /// Загрузить картинку по запросу постранично
    /// - Parameter queryString: строка запроса
    func loadPicturesByQueryWithPaging(queryString: String) {
        let newPage = currentPagesCount + 1
        
        PicturesAPI.getPicturesByQuery(queryString: queryString, page: newPage, perPage: maxItemsInPage).then { [weak self] response in
            guard let `self` = self else { return }
            self.currentPagesCount += 1
            
            self.presenter?.loadPicturesFromPage(picturesObjects: self.loadFavoriteData(for: response.photos))
        }.catch { error in
            print("error")
        }
    }
    
    func changeFavoriteStatus(for id: Int, newStatus: Bool) {
        if newStatus {
            favoriteDataSource.setFavorite(pictureID: id)
        } else {
            favoriteDataSource.deleteFavorite(pictureID: id)
        }
    }
}
