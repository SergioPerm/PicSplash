//
//  PictureDetailDependecy.swift
//  PicSplash
//
//  Created by Sergio Lechini on 31.08.2021.
//

import Foundation
import DITranquillity

class PictureDetailDependency {
    static func load(container: DIContainer) {
                
//        container.register {
//            PictureDetailRouter(navigationController: $0, pictureDetailViewProvider: $1)
//        }.as(PictureDetailRoutingLogic.self)
//
//        container.register {
//            PictureDetailPresenter(view: $0, router: $1, interactor: $2)
//        }.as(PictureDetailPresentationLogic.self).as(PictureDetailViewControllerOutput.self).lifetime(.objectGraph)
//
//        container.register {
//            PictureDetailViewController()
//        }.injection(cycle: true, \.presenter).as(PictureDetailDisplayLogic.self).lifetime(.objectGraph)
//
//        container.register {
//            PictureDetailInteractor(picture: arg($0))
//        }.injection(cycle: true, \.presenter).as(PictureDetailBusinessLogic.self).lifetime(.objectGraph)
        
        container.register(PictureDetailRouter.init).as(PictureDetailRoutingLogic.self)
        container.register(PictureDetailPresenter.init).as(PictureDetailPresentationLogic.self).as(PictureDetailViewControllerOutput.self).lifetime(.objectGraph).injection(cycle: true, \.interactor)
        container.register(PictureDetailViewController.init).injection(cycle: true, \.presenter).as(PictureDetailDisplayLogic.self).lifetime(.objectGraph)
        container.register(PictureDetailInteractor.init).as(PictureDetailBusinessLogic.self).injection(cycle: true, \.presenter)

    }
}
