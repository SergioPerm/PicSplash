//
//  LoginInteractor.swift
//  PicSplash
//
//  Created by Sergio Lechini on 08.09.2021.
//

import Foundation

/// Протокол для работы с LoginInteractor
protocol LoginBusinessLogic {
    ///Логин с помощью API key
    /// - Parameter apiKey: строка с API key
    func login(apiKey: String)
    /// Проверить статус авторизации
    func checkAuthorization()
}

final class LoginInteractor {
    weak var presenter: LoginPresentationLogic?
    
    private let networkAPI: LoginNetworking
    private let keyChainStore: KeyChainStore
    
    init(keyChainStore: KeyChainStore, networkAPI: LoginNetworking) {
        self.keyChainStore = keyChainStore
        self.networkAPI = networkAPI
    }
}

// MARK: MenuBusinessLogic
extension LoginInteractor: LoginBusinessLogic {
    /// Проверить статус авторизации
    func checkAuthorization() {
        guard let currentApiKey = keyChainStore.getApiKey(for: Consts.Links.pexelBaseUrl) else {
            return
        }
        
        networkAPI.checkConnection(apiKey: currentApiKey).then { response in
            self.presenter?.goToApp()
        }
    }
    ///Логин с помощью API key
    /// - Parameter apiKey: строка с API key
    func login(apiKey: String) {
        networkAPI.checkConnection(apiKey: apiKey).then { response in
            self.saveApiKey(apiKey: apiKey)
        }.catch { error in
            self.presenter?.showError(errorDesc: "Bad API key")
        }
    }
}

private extension LoginInteractor {
    /// Сохранить API key
    /// - Parameter apiKey: строка с API key
    func saveApiKey(apiKey: String) {
        keyChainStore.setApiKey(apiKey, for: Consts.Links.pexelBaseUrl)
        presenter?.goToApp()
    }
}
