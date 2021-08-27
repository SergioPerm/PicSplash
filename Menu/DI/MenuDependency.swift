//
//  MenuDependency.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation
import DITranquillity

class MenuDependency {
    static func load(container: DIContainer) {
        container.register(MenuRouter.init).as(MenuRoutingLogic.self)
        container.register(MenuPresenter.init).as(MenuPresentationLogic.self).as(MenuViewControllerOutput.self).lifetime(.objectGraph)
        container.register(MenuViewController.init).injection(cycle: true, \.presenter).as(MenuDisplayLogic.self).lifetime(.objectGraph)
        container.register(MenuInteractor.init).injection(cycle: true, \.presenter).as(MenuBusinessLogic.self).lifetime(.objectGraph)
    }
}
