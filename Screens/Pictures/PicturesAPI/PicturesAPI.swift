//
//  PicturesAPI.swift
//  PicSplash
//
//  Created by Sergio Lechini on 30.08.2021.
//

import Foundation
import Promises

/// Протокол для работы с PicturesAPI
protocol PicturesNetworking {
    /// Получить картинки постранично
    /// - Parameters:
    ///   - page: для страницы
    ///   - perPage: объектов на странице
    func getPictures(page: Int, perPage: Int) -> Promise<PicturesResponse>
    /// Получить картинки по запросу
    /// - Parameters:
    ///   - queryString: строка запроса
    ///   - page: для страницы
    ///   - perPage: объектов на странице
    func getPicturesByQuery(queryString: String, page: Int, perPage: Int) -> Promise<PicturesResponse>
}

final class PicturesAPI {
    private let networkService: PicSplashNetwork = AppDI.resolve()
}

// MARK: PicturesNetworking
extension PicturesAPI: PicturesNetworking {
    /// Получить картинки постранично
    /// - Parameters:
    ///   - page: для страницы
    ///   - perPage: объектов на странице
    func getPictures(page: Int, perPage: Int) -> Promise<PicturesResponse> {
        return networkService.request(PicturesRequest.getPictures(page: page, perPage: perPage))
    }
    /// Получить картинки по запросу
    /// - Parameters:
    ///   - queryString: строка запроса
    ///   - page: для страницы
    ///   - perPage: объектов на странице
    func getPicturesByQuery(queryString: String, page: Int, perPage: Int) -> Promise<PicturesResponse> {
        return networkService.request(PicturesRequest.getPicturesByQuery(queryString: queryString, page: page, perPage: perPage))
    }
}
