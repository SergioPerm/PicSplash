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
                
        container.register(PictureDetailRouter.init).as(PictureDetailRoutingLogic.self)
        container.register(PictureDetailPresenter.init).as(PictureDetailPresentationLogic.self).as(PictureDetailViewControllerOutput.self).lifetime(.objectGraph).injection(cycle: true, \.interactor)
        container.register(PictureDetailViewController.init).injection(cycle: true, \.presenter).as(PictureDetailDisplayLogic.self).lifetime(.objectGraph)
        container.register(PictureDetailInteractor.init(networkAPI:)).as(PictureDetailBusinessLogic.self).injection(cycle: true, \.presenter)

    }
}
