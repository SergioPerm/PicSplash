//
//  PicturesPresenter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation

/// Протокол для работы с Presenter из viewModels
protocol PicturesHandlers: AnyObject {
    /// Выбрать картинку
    /// - Parameter picture: объект картинки
    func selectPicture(picture: Picture)
    /// Сменить статус избранного у картинки
    /// - Parameter picture: объект картинки
    func setFavorite(picture: Picture)
}

/// Протокол работы с PicturesPresenter
protocol PicturesPresentationLogic: AnyObject {
    /// Загрузить картинки
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPictures(picturesObjects: [Picture])
    /// Загрузить картинки постранично
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPicturesFromPage(picturesObjects: [Picture])
}

/// Протокол для работы c PicturesPresenter из PicturesViewController
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

// MARK: PicturesPresentationLogic
extension PicturesPresenter: PicturesPresentationLogic {
    /// Загрузить картинки
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPictures(picturesObjects: [Picture]) {
        let viewModels = picturesObjects.map({ PictureViewModel(picture: $0, handlers: self) })
        viewController?.reloadPictures(pictures: viewModels)
    }
    
    /// Загрузить картинки постранично
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPicturesFromPage(picturesObjects: [Picture]) {
        let viewModels = picturesObjects.map({ PictureViewModel(picture: $0, handlers: self) })
        viewController?.addPictures(pictures: viewModels)
    }
}

// MARK: PicturesViewControllerOutput
extension PicturesPresenter: PicturesViewControllerOutput {
    /// Перезагрузить картинки
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

// MARK: PicturesHandlers
extension PicturesPresenter: PicturesHandlers {
    /// Выбрать картинку
    /// - Parameter picture: объект картинки
    func selectPicture(picture: Picture) {
        router?.routeTo(target: .detailPicture(picture: picture))
    }
    /// Сменить статус избранного у картинки
    /// - Parameter picture: объект картинки
    func setFavorite(picture: Picture) {
        interactor?.changeFavoriteStatus(picture: picture)
    }
}
