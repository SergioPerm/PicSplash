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
    
    static func getPicturesByQuery(queryString: String, page: Int, perPage: Int) -> Promise<PicturesResponse> {
        let networkService: PicSplashNetwork = AppDI.resolve()
        
        return networkService.request(PicturesRequest.getPicturesByQuery(queryString: queryString, page: page, perPage: perPage))
    }
}
