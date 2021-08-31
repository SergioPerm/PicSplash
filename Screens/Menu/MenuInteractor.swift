//
//  MenuInteractor.swift
//  PicSplash
//
//  Created by Sergio Lechini on 23.08.2021.
//

import Foundation

/// Протокол для работы с MenuInteractor
protocol MenuBusinessLogic { }

final class MenuInteractor {
    weak var presenter: MenuPresentationLogic?
}

// MARK: MenuBusinessLogic
extension MenuInteractor: MenuBusinessLogic { }
