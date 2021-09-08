//
//  MenuInteractor.swift
//  PicSplash
//
//  Created by Sergio Lechini on 23.08.2021.
//

import Foundation

/// Протокол для работы с MenuInteractor
protocol MenuBusinessLogic {
    func logout()
}

final class MenuInteractor {
    weak var presenter: MenuPresentationLogic?
    private let keyChainStore: KeyChainStore
    
    init(keyChainStore: KeyChainStore) {
        self.keyChainStore = keyChainStore
    }
}

// MARK: MenuBusinessLogic
extension MenuInteractor: MenuBusinessLogic {
    func logout() {
        keyChainStore.deleteApiKey(for: Consts.Links.pexelBaseUrl)
        presenter?.closeMenu()
    }
}
