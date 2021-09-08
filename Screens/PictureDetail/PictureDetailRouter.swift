//
//  PictureDetailRouter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 31.08.2021.
//

import UIKit
import SwiftLazy

/// Протокол для работы с PictureDetailRouter из Presenter
protocol PictureDetailRoutingLogic {
    /// Перейти на новый экран
    /// - Parameter target: Target
    func routeTo(target: PictureDetailRouter.Targets)
}

final class PictureDetailRouter {
    var navigationController: UINavigationController?
    private let pictureDetailViewProvider: Provider<PictureDetailViewController>?
    
    init(navigationController: GlobalNavigationViewController, pictureDetailViewProvider: Provider<PictureDetailViewController>) {
        self.navigationController = navigationController
        self.pictureDetailViewProvider = pictureDetailViewProvider
    }
    
    func start(picture: Picture) {
        guard let view = pictureDetailViewProvider?.value else { return }
        
        // In DiTranqulity temporary dont work arguments transfert
        // Crutch
        if let presenter = view.presenter as? PictureDetailPresenter, let interactor = presenter.interactor as? PictureDetailInteractor {
            interactor.picture = picture
        }
        
        navigationController?.pushViewController(view, animated: true)
    }
    
    enum Targets {
        case someRoute
    }
}

// MARK: PictureDetailRoutingLogic
extension PictureDetailRouter: PictureDetailRoutingLogic {
    /// Перейти на новый экран
    /// - Parameter target: Target
    func routeTo(target: Targets) {
        
    }
}
