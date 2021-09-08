//
//  FavoritesPresenter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 02.09.2021.
//

import Foundation

/// Протокол работы с FavoritesPresenter
protocol FavoritesPresentationLogic: AnyObject {
    /// Загрузить картинки
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPictures(picturesObjects: [Picture])
    /// Удалить картинку
    /// - Parameter pictureID: id картинки
    func removePicture(pictureID: Int)
}

/// Протокол для работы c FavoritesPresenter из FavoritesViewController
protocol FavoritesViewControllerOutput {
    /// Перезагрузить картинки
    func loadPictures()
}

final class FavoritesPresenter {
    let interactor: FavoritesBusinessLogic?
    let router: FavoritesRoutingLogic?
        
    weak var viewController: FavoritesDisplayLogic?
    
    init(view: FavoritesDisplayLogic, router: FavoritesRoutingLogic, interactor: FavoritesBusinessLogic) {
        self.viewController = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: FavoritesPresentationLogic
extension FavoritesPresenter: FavoritesPresentationLogic{
    /// Загрузить картинки
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPictures(picturesObjects: [Picture]) {
        var viewModels: [PictureViewModelType] = []
        
        picturesObjects.forEach({
            viewModels.append(PictureViewModel(picture: $0, handlers: self))
        })
        
        viewController?.reloadPictures(pictures: viewModels)
    }
    /// Удалить картинку
    /// - Parameter pictureID: id картинки
    func removePicture(pictureID: Int) {
        viewController?.removePicture(pictureID: pictureID)
    }
}

// MARK: FavoritesViewControllerOutput
extension FavoritesPresenter: FavoritesViewControllerOutput {
    /// Перезагрузить картинки
    func loadPictures() {
        interactor?.loadPictures()
    }
}

extension FavoritesPresenter: PicturesHandlers {
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
