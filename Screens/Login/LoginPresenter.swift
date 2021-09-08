//
//  LoginPresenter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 08.09.2021.
//

import Foundation

/// Протокол работы с LoginPresenter
protocol LoginPresentationLogic: AnyObject {
    /// Перейти в приложение
    func goToApp()
    /// Показать ошибку
    /// - Parameter errorDesc: описание ошибки
    func showError(errorDesc: String)
}

/// Протокол для работы c LoginPresenter из LoginViewController
protocol LoginViewControllerOutput {
    /// Попытаться залогиниться с помощью API key
    /// - Parameter apiKey: строка с API key
    func login(apiKey: String)
    /// Проверить статус авторизации
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

// MARK: LoginViewControllerOutput
extension LoginPresenter: LoginViewControllerOutput {
    /// Проверить статус авторизации
    func checkAuthorization() {
        interactor?.checkAuthorization()
    }
    /// Попытаться залогиниться с помощью API key
    /// - Parameter apiKey: строка с API key
    func login(apiKey: String) {
        interactor?.login(apiKey: apiKey)
    }
}

// MARK: LoginPresentationLogic
extension LoginPresenter: LoginPresentationLogic {
    /// Перейти в приложение
    func goToApp() {
        router?.routeTo(target: .menu)
    }
    /// Показать ошибку
    /// - Parameter errorDesc: описание ошибки
    func showError(errorDesc: String) {
        viewController?.showLoginError(errorDesc: errorDesc)
    }
}
