//
//  PicturesPresenter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation


/// Протокол работы с MenuPresenter
protocol PicturesPresentationLogic: AnyObject {
    
}

/// Протокол для работы c MenuPresenter из MenuViewController
protocol PicturesViewControllerOutput {

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
    
}

// MARK: MenuViewControllerOutput
extension PicturesPresenter: PicturesViewControllerOutput {

}
