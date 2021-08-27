//
//  AppDI.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation
import DITranquillity

class AppDI {
    private static let container: DIContainer = DIContainer()
    
    static func reg() {
        DISetting.Log.level = .warning
        AppDependency.load(container: container)
        MenuDependency.load(container: container)
        
        container.initializeSingletonObjects()
    }
    
    static func resolve<T>() -> T {
        return container.resolve()
    }
    
    static func resolve<T, Tag>(withTag: Tag.Type) -> T {
        return container.resolve(tag: withTag)
    }
}
