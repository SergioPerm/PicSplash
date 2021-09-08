//
//  PictureDetailAPI.swift
//  PicSplash
//
//  Created by Sergio Lechini on 31.08.2021.
//

import Foundation
import Promises

protocol PictureDetailNetworking {
    /// Загрузить бинарные данные картинки
    /// - Parameter url: адрес картинки
    func loadImageData(url: String) -> Promise<Data>
}

final class PictureDetailAPI {
    private let networkService: PicSplashNetwork = AppDI.resolve()
}

extension PictureDetailAPI: PictureDetailNetworking {
    /// Загрузить бинарные данные картинки
    /// - Parameter url: адрес картинки
    func loadImageData(url: String) -> Promise<Data> {
        return networkService.requestData(URL(string: url))
    }
}
