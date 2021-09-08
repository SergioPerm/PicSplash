//
//  LoginAPI.swift
//  PicSplash
//
//  Created by Sergio Lechini on 08.09.2021.
//

import Foundation
import Promises

/// Протокол для работы с LoginAPI
protocol LoginNetworking {
    /// Проверить коннект с помощью API key
    /// - Parameter apiKey: строка с API key
    func checkConnection(apiKey: String) -> Promise<PicturesResponse>
}

final class LoginAPI {
    private let networkService: PicSplashNetwork = AppDI.resolve()
}

extension LoginAPI: LoginNetworking {
    /// Проверить коннект с помощью API key
    /// - Parameter apiKey: строка с API key
    func checkConnection(apiKey: String) -> Promise<PicturesResponse> {
        return networkService.request(LoginRequest.checkConnection(apiKey: apiKey))
    }
}
