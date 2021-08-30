//
//  PicturesPresenter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation


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
}

final class PicturesPresenter {
    let interactor: PicturesBusinessLogic?
    let router: PicturesRoutingLogic?
    
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
            viewModels.append(PictureViewModel(picture: $0))
        })
        
        viewController?.reloadPictures(pictures: viewModels)
    }
    
    /// Загрузить картинки постранично
    /// - Parameter picturesObjects: Массив объектов картинок
    func loadPicturesFromPage(picturesObjects: [Picture]) {
        var viewModels: [PictureViewModelType] = []
        
        picturesObjects.forEach({
            viewModels.append(PictureViewModel(picture: $0))
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
        interactor?.loadPicturesWithPaging()
    }
}
