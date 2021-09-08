//
//  AppDI.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation
import DITranquillity

/// Класс для управления зависимостям и регистрации контейнеров
final class AppDI {
    static let container: DIContainer = DIContainer()
    
    /// Регим основные зависимости
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
    
    /// Получить объект из DI контейнера
    /// - Parameter arguments: аргументы для передачи в зависимость
    /// - Returns: Объект
    static func resolve<T>(with arguments: AnyArguments) -> T {
        return container.resolve(arguments: arguments)
    }
    
    /// Получить объект из DI контейнера
    /// - Returns: Объект
    static func resolve<T>() -> T {
        return container.resolve()
    }
    
    /// Получить объект из DI контейнера
    /// - Parameter withTag: tag для зарегистррованного обхекта
    /// - Returns: Объект
    static func resolve<T, Tag>(withTag: Tag.Type) -> T {
        return container.resolve(tag: withTag)
    }
}
