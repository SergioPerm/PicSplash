//
//  AppDependency.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation
import DITranquillity

class AppDependency: DIPart {
    static func load(container: DIContainer) {
        container.register{GlobalNavigationViewController()}.lifetime(.perRun(.strong))
        container.register{PicSplashNetwork()}.lifetime(.perRun(.strong))
    }
}
