//
//  PictureDetailPresenter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 31.08.2021.
//

import Foundation
import SwiftLazy

/// Протокол работы с PictureDetailPresenter
protocol PictureDetailPresentationLogic: AnyObject {
    /// Показать картинку
    /// - Parameter data: данные картинки
    func showImage(data: Data)
}

/// Протокол для работы c PictureDetailPresenter из PictureDetailViewController
protocol PictureDetailViewControllerOutput {
    /// Загрузить картинку
    func loadImage()
}

final class PictureDetailPresenter {
    var interactor: PictureDetailBusinessLogic?
    var router: PictureDetailRoutingLogic?
    
    weak var viewController: PictureDetailDisplayLogic?
    
    init(view: PictureDetailDisplayLogic, router: PictureDetailRoutingLogic) {
        self.viewController = view
        self.router = router
    }
}

// MARK: PictureDetailPresentationLogic
extension PictureDetailPresenter: PictureDetailPresentationLogic {
    /// Показать картинку
    /// - Parameter data: данные картинки
    func showImage(data: Data) {
        viewController?.showPicture(data: data)
    }
}

// MARK: PictureDetailViewControllerOutput
extension PictureDetailPresenter: PictureDetailViewControllerOutput {
    /// Загрузить картинку
    func loadImage() {
        interactor?.loadImage()
    }
}
