//
//  PicturesRouter.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import UIKit
import SwiftLazy
import DITranquillity

/// Протокол для работы с PicturesRouter из Presenter
protocol PicturesRoutingLogic {
    /// Перейти на новый экран
    /// - Parameter target: Target
    func routeTo(target: PicturesRouter.Targets)
}

final class PicturesRouter {
    var navigationController: UINavigationController?
    private let picturesViewProvider: Provider<PicturesViewController>?
    
    init(navigationController: GlobalNavigationViewController, picturesViewProvider: Provider<PicturesViewController>) {
        self.navigationController = navigationController
        self.picturesViewProvider = picturesViewProvider
    }
    
    func start() {
        guard let view = picturesViewProvider?.value else { return }
        
        navigationController?.pushViewController(view, animated: true)
    }
    
    enum Targets {
        case detailPicture(picture: Picture)
    }
}

// MARK: PicturesRoutingLogic
extension PicturesRouter: PicturesRoutingLogic {
    /// Перейти на новый экран
    /// - Parameter target: Target
    func routeTo(target: Targets) {
        switch target {
        case .detailPicture(let picture):
            let pictureDetailRouter: PictureDetailRouter = AppDI.resolve()
            pictureDetailRouter.start(picture: picture)
        }
    }
}
