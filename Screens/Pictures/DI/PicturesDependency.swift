//
//  PicturesDependency.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation
import DITranquillity

class PicturesDependency {
    static func load(container: DIContainer) {
        container.register(PicturesRouter.init).as(PicturesRoutingLogic.self)
        container.register(PicturesPresenter.init).as(PicturesPresentationLogic.self).as(PicturesViewControllerOutput.self).lifetime(.objectGraph)
        container.register(PicturesViewController.init).injection(cycle: true, \.presenter).as(PicturesDisplayLogic.self).lifetime(.objectGraph)
        container.register(PicturesInteractor.init).injection(cycle: true, \.presenter).as(PicturesBusinessLogic.self).lifetime(.objectGraph)
    }
}
