//
//  FavoritesRouter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 02.09.2021.
//

import UIKit
import SwiftLazy
import DITranquillity

/// Протокол для работы с FavoritesRouter из Presenter
protocol FavoritesRoutingLogic {
    /// Перейти на новый экран
    /// - Parameter target: Target
    func routeTo(target: FavoritesRouter.Targets)
}

final class FavoritesRouter {
    var navigationController: UINavigationController?
    private let favoritesViewProvider: Provider<FavoritesViewController>?
    
    init(navigationController: GlobalNavigationViewController, favoritesViewProvider: Provider<FavoritesViewController>) {
        self.navigationController = navigationController
        self.favoritesViewProvider = favoritesViewProvider
    }
    
    func start() {
        guard let view = favoritesViewProvider?.value else { return }
        
        navigationController?.pushViewController(view, animated: true)
    }
    
    enum Targets {
        case detailPicture(picture: Picture)
    }
}

// MARK: FavoritesRoutingLogic
extension FavoritesRouter: FavoritesRoutingLogic {
    /// Перейти на новый экран
    /// - Parameter target: Target
    func routeTo(target: Targets) {
        switch target {
        case .detailPicture(let picture):
            let pictureDetailRouter: PictureDetailRouter = AppDI.resolve()
            pictureDetailRouter.start(picture: picture)
        }
    }
}
