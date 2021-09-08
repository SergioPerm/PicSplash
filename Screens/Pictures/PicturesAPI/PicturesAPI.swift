//
//  PicturesAPI.swift
//  PicSplash
//
//  Created by Sergio Lechini on 30.08.2021.
//

import Foundation
import Promises

protocol PicturesNetworking {
    func getPictures(page: Int, perPage: Int) -> Promise<PicturesResponse>
    func getPicturesByQuery(queryString: String, page: Int, perPage: Int) -> Promise<PicturesResponse>
}

final class PicturesAPI {
    private let networkService: PicSplashNetwork = AppDI.resolve()
}

extension PicturesAPI: PicturesNetworking {
    func getPictures(page: Int, perPage: Int) -> Promise<PicturesResponse> {
        return networkService.request(PicturesRequest.getPictures(page: page, perPage: perPage))
    }
    
    func getPicturesByQuery(queryString: String, page: Int, perPage: Int) -> Promise<PicturesResponse> {
        return networkService.request(PicturesRequest.getPicturesByQuery(queryString: queryString, page: page, perPage: perPage))
    }
}
