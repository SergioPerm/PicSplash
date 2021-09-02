//
//  PicturesPresenter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation

protocol PicturesHandlers: AnyObject {
    func selectPicture(picture: Picture)
    func setFavorite(pictureID: Int, newStatus: Bool)
}

/// Протокол работы с MenuPresenter
protocol PicturesPresentationLogic: AnyObject {
    /// Загрузить картинки
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPictures(picturesObjects: [Picture])
    /// Загрузить картинки постранично
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPicturesFromPage(picturesObjects: [Picture])
}

/// Протокол для работы c MenuPresenter из MenuViewController
protocol PicturesViewControllerOutput {
    /// Перезагрузить картинки
    func loadPictures()
    /// Загрузить новую страницу картинок
    func loadPicturesNewPage()
    /// Установить данные поиска
    /// - Parameter queryString: Строка поиска
    func setQuery(queryString: String)
}

final class PicturesPresenter {
    let interactor: PicturesBusinessLogic?
    let router: PicturesRoutingLogic?
    
    private var currentQueryString = ""
    private let minQueryCountChars = 3
    
    weak var viewController: PicturesDisplayLogic?
    
    init(view: PicturesDisplayLogic, router: PicturesRoutingLogic, interactor: PicturesBusinessLogic) {
        self.viewController = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: MenuPresentationLogic
extension PicturesPresenter: PicturesPresentationLogic{
    func loadPictures(picturesObjects: [Picture]) {
        var viewModels: [PictureViewModelType] = []
        
        picturesObjects.forEach({
            viewModels.append(PictureViewModel(picture: $0, handlers: self))
        })
        
        viewController?.reloadPictures(pictures: viewModels)
    }
    
    /// Загрузить картинки постранично
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPicturesFromPage(picturesObjects: [Picture]) {
        var viewModels: [PictureViewModelType] = []
        
        picturesObjects.forEach({
            viewModels.append(PictureViewModel(picture: $0, handlers: self))
        })
        
        viewController?.addPictures(pictures: viewModels)
    }
}

// MARK: MenuViewControllerOutput
extension PicturesPresenter: PicturesViewControllerOutput {
    func loadPictures() {
        interactor?.loadPictures()
    }
    /// Загрузить новую страницу картинок
    func loadPicturesNewPage() {
        
        if currentQueryString.isEmpty {
            interactor?.loadPicturesWithPaging()
        } else {
            interactor?.loadPicturesByQueryWithPaging(queryString: currentQueryString)
        }
    }
    /// Установить данные поиска
    /// - Parameter queryString: Строка поиска
    func setQuery(queryString: String) {
        if queryString.isEmpty && !currentQueryString.isEmpty {
            currentQueryString = ""
            interactor?.loadPictures()
            return
        } else if queryString.count < minQueryCountChars {
            currentQueryString = ""
            return
        }
        
        currentQueryString = queryString
        interactor?.loadPicturesByQuery(queryString: queryString)
    }
}

extension PicturesPresenter: PicturesHandlers {
    func selectPicture(picture: Picture) {
        router?.routeTo(target: .detailPicture(picture: picture))
    }
    
    func setFavorite(pictureID: Int, newStatus: Bool) {
        interactor?.changeFavoriteStatus(for: pictureID, newStatus: newStatus)
    }
}
