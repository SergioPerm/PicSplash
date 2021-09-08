//
//  LoginPresenter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 08.09.2021.
//

import Foundation

/// Протокол работы с MenuPresenter
protocol LoginPresentationLogic: AnyObject {
    func goToApp()
    func showError(errorDesc: String)
}

/// Протокол для работы c MenuPresenter из MenuViewController
protocol LoginViewControllerOutput {
    func login(apiKey: String)
    func checkAuthorization()
}

final class LoginPresenter {
    let interactor: LoginBusinessLogic?
    let router: LoginRoutingLogic?
        
    weak var viewController: LoginDisplayLogic?
    
    init(view: LoginDisplayLogic, router: LoginRoutingLogic, interactor: LoginBusinessLogic) {
        self.viewController = view
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginViewControllerOutput {
    func checkAuthorization() {
        interactor?.checkAuthorization()
    }
    
    func login(apiKey: String) {
        interactor?.login(apiKey: apiKey)
    }
}

extension LoginPresenter: LoginPresentationLogic {
    func goToApp() {
        router?.routeTo(target: .menu)
    }
    
    func showError(errorDesc: String) {
        viewController?.showLoginError(errorDesc: errorDesc)
    }
}
