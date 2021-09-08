//
//  LoginDependency.swift
//  PicSplash
//
//  Created by Sergio Lechini on 08.09.2021.
//

import Foundation
import DITranquillity

class LoginDependency {
    static func load(container: DIContainer) {
        container.register(LoginRouter.init).as(LoginRoutingLogic.self)
        container.register(LoginPresenter.init).as(LoginPresentationLogic.self).as(LoginViewControllerOutput.self).lifetime(.objectGraph)
        container.register(LoginViewController.init).injection(cycle: true, \.presenter).as(LoginDisplayLogic.self).lifetime(.objectGraph)
        container.register(LoginInteractor.init(keyChainStore:networkAPI:)).injection(cycle: true, \.presenter).as(LoginBusinessLogic.self).lifetime(.objectGraph)
    }
}
