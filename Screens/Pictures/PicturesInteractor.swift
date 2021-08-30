//
//  PicturesInteractor.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation

/// Протокол для работы с MenuInteractor
protocol PicturesBusinessLogic {
    /// Загрузить картинки
    func loadPictures()
}

final class PicturesInteractor {
    weak var presenter: PicturesPresentationLogic?
}

// MARK: MenuBusinessLogic
extension PicturesInteractor: PicturesBusinessLogic {
    private func createURLFromParameters(parameters: [String:Any]) -> URL? {

        var components = URLComponents()
        components.scheme = "https"
        components.host   = "api.pexels.com"
        components.path   = "/v1/curated"

        if !parameters.isEmpty {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }

        return components.url
    }
    
    
    /// Загрузить картинки
    func loadPictures() {
        PicturesAPI.getPictures(page: 1, perPage: 8).then { [weak self] response in
            self?.presenter?.loadPictures(picturesObjects: response.photos)
        }.catch { error in
            print("error")
        }
    }
}
