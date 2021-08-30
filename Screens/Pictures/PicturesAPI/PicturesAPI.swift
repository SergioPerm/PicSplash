//
//  PicturesAPI.swift
//  PicSplash
//
//  Created by Sergio Lechini on 30.08.2021.
//

import Foundation
import Promises

struct PicturesAPI {
    static func getPictures(page: Int, perPage: Int) -> Promise<PicturesResponse> {
        let networkService: PicSplashNetwork = AppDI.resolve()
        
        return networkService.request(PicturesRequest.getPictures(page: page, perPage: perPage))
    }
}
