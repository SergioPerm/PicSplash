//
//  MenuRouter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 23.08.2021.
//

import UIKit
import SwiftLazy

/// Протокол для работы с MenuRouter из Presenter
protocol MenuRoutingLogic {
    func routeTo(target: MenuRouter.Targets)
}

final class MenuRouter {
    var navigationController: UINavigationController?
    private let menuViewProvider: Provider<MenuViewController>?
    
    init(navigationController: GlobalNavigationViewController, menuViewProvider: Provider<MenuViewController>) {
        self.navigationController = navigationController
        self.menuViewProvider = menuViewProvider
    }
    
    func start() {
        guard let view = menuViewProvider?.value else { return }
        
        navigationController?.pushViewController(view, animated: false)
    }
    
    enum Targets {
        case pictures
        case favorites
    }
}

// MARK: MenuRoutingLogic
extension MenuRouter: MenuRoutingLogic {
    func routeTo(target: Targets) {
        switch target {
        case .pictures:
            let picturesRouter: PicturesRouter = AppDI.resolve()
            picturesRouter.start()
        case .favorites:
            let favoritesRouter: FavoritesRouter = AppDI.resolve()
            favoritesRouter.start()
        }
    }
}
