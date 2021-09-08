//
//  AppDI.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation
import DITranquillity

class AppDI {
    static let container: DIContainer = DIContainer()
    
    static func reg() {
        DISetting.Log.level = .info
        AppDependency.load(container: container)
        LoginDependency.load(container: container)
        MenuDependency.load(container: container)
        PicturesDependency.load(container: container)
        FavoritesDependency.load(container: container)
        PictureDetailDependency.load(container: container)
        
        container.initializeSingletonObjects()
    }
    
    static func resolve<T>(with arguments: AnyArguments) -> T {
        return container.resolve(arguments: arguments)
    }
    
    static func resolve<T>() -> T {
        return container.resolve()
    }
    
    static func resolve<T, Tag>(withTag: Tag.Type) -> T {
        return container.resolve(tag: withTag)
    }
}
