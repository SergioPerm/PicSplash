//
//  PictureDetailPresenter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 31.08.2021.
//

import Foundation
import SwiftLazy

/// Протокол работы с MenuPresenter
protocol PictureDetailPresentationLogic: AnyObject {
    func showImage(data: Data)
}

/// Протокол для работы c MenuPresenter из MenuViewController
protocol PictureDetailViewControllerOutput {
    func loadImage()
}

class PictureDetailPresenter {
    var interactor: PictureDetailBusinessLogic?
    var router: PictureDetailRoutingLogic?
    
    weak var viewController: PictureDetailDisplayLogic?
    
    init(view: PictureDetailDisplayLogic, router: PictureDetailRoutingLogic) {
        self.viewController = view
        self.router = router
    }
}

extension PictureDetailPresenter: PictureDetailPresentationLogic {
    func showImage(data: Data) {
        viewController?.showPicture(data: data)
    }
}

extension PictureDetailPresenter: PictureDetailViewControllerOutput {
    func loadImage() {
        interactor?.loadImage()
    }
}
