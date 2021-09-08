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
        container.register{PicturesAPI()}.as(PicturesNetworking.self).lifetime(.perRun(.strong))
        container.register{LoginAPI()}.as(LoginNetworking.self).lifetime(.perRun(.strong))
        container.register{FavoritesUserDefaults()}.as(FavoritesDataSource.self).lifetime(.perRun(.strong))
        container.register{KeyChainManager()}.as(KeyChainStore.self).lifetime(.perRun(.strong))
    }
}
