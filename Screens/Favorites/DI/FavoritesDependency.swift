//
//  FavoritesDependency.swift
//  PicSplash
//
//  Created by Sergio Lechini on 02.09.2021.
//

import Foundation
import DITranquillity

class FavoritesDependency {
    static func load(container: DIContainer) {
        container.register(FavoritesRouter.init).as(FavoritesRoutingLogic.self)
        container.register(FavoritesPresenter.init).as(FavoritesPresentationLogic.self).as(FavoritesViewControllerOutput.self).lifetime(.objectGraph)
        container.register(FavoritesViewController.init).injection(cycle: true, \.presenter).as(FavoritesDisplayLogic.self).lifetime(.objectGraph)
        container.register(FavoritesInteractor.init(dataSource:)).injection(cycle: true, \.presenter).as(FavoritesBusinessLogic.self).lifetime(.objectGraph)
    }
}
