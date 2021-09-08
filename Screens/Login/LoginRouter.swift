//
//  LoginRouter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 08.09.2021.
//

import UIKit
import SwiftLazy
import DITranquillity

/// Протокол для работы с MenuRouter из Presenter
protocol LoginRoutingLogic {
    func routeTo(target: LoginRouter.Targets)
}

final class LoginRouter {
    var navigationController: UINavigationController?
    private let loginViewProvider: Provider<LoginViewController>?
    
    init(navigationController: GlobalNavigationViewController, loginViewProvider: Provider<LoginViewController>) {
        self.navigationController = navigationController
        self.loginViewProvider = loginViewProvider
    }
    
    func start() {
        guard let view = loginViewProvider?.value else { return }
        
        navigationController?.pushViewController(view, animated: true)
    }
    
    enum Targets {
        case menu
    }
}

// MARK: MenuRoutingLogic
extension LoginRouter: LoginRoutingLogic {
    func routeTo(target: Targets) {
        switch target {
        case .menu:
            let menuRouter: MenuRouter = AppDI.resolve()
            menuRouter.start()
        }
    }
}
