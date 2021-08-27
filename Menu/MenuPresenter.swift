//
//  MenuPresenter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 23.08.2021.
//

import Foundation

/// Протокол работы с MenuPresenter
protocol MenuPresentationLogic: AnyObject {
    
}

/// Протокол для работы c MenuPresenter из MenuViewController
protocol MenuViewControllerOutput {
    
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
    
}

// MARK: MenuViewControllerOutput
extension MenuPresenter: MenuViewControllerOutput {
    
}


