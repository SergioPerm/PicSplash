//
//  FavoritesPresenter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 02.09.2021.
//

import Foundation

/// Протокол работы с MenuPresenter
protocol FavoritesPresentationLogic: AnyObject {
    /// Загрузить картинки
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPictures(picturesObjects: [Picture])
    func removePicture(pictureID: Int)
}

/// Протокол для работы c MenuPresenter из MenuViewController
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

// MARK: MenuPresentationLogic
extension FavoritesPresenter: FavoritesPresentationLogic{
    func loadPictures(picturesObjects: [Picture]) {
        var viewModels: [PictureViewModelType] = []
        
        picturesObjects.forEach({
            viewModels.append(PictureViewModel(picture: $0, handlers: self))
        })
        
        viewController?.reloadPictures(pictures: viewModels)
    }
    
    func removePicture(pictureID: Int) {
        viewController?.removePicture(pictureID: pictureID)
    }
}

// MARK: MenuViewControllerOutput
extension FavoritesPresenter: FavoritesViewControllerOutput {
    func loadPictures() {
        interactor?.loadPictures()
    }
}

extension FavoritesPresenter: PicturesHandlers {
    func selectPicture(picture: Picture) {
        router?.routeTo(target: .detailPicture(picture: picture))
    }
    
    func setFavorite(picture: Picture) {
        interactor?.changeFavoriteStatus(picture: picture)
    }
}
