//
//  MenuPresenter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 23.08.2021.
//

import Foundation

/// Протокол работы с MenuPresenter
protocol MenuPresentationLogic: AnyObject {
    func closeMenu()
}

/// Протокол для работы c MenuPresenter из MenuViewController
protocol MenuViewControllerOutput {
    /// Открыть экран картинок
    func openPictures()
    func openFavorites()
    func logout()
}

final class MenuPresenter {
    let interactor: MenuBusinessLogic?
    let router: MenuRoutingLogic?
    
    weak var viewController: MenuDisplayLogic?
    
    init(view: MenuDisplayLogic, router: MenuRoutingLogic, interactor: MenuBusinessLogic) {
        self.viewController = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: MenuPresentationLogic
extension MenuPresenter: MenuPresentationLogic{
    func closeMenu() {
        viewController?.closeMenu()
    }
}

// MARK: MenuViewControllerOutput
extension MenuPresenter: MenuViewControllerOutput {
    /// Открыть экран картинок
    func openPictures() {
        router?.routeTo(target: .pictures)
    }
    
    func openFavorites() {
        router?.routeTo(target: .favorites)
    }
    
    func logout() {
        interactor?.logout()
    }
}


