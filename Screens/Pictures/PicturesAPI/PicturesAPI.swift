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

class PicturesAPI: PicturesNetworking {
    func getPictures(page: Int, perPage: Int) -> Promise<PicturesResponse> {
        let networkService: PicSplashNetwork = AppDI.resolve()
        
        return networkService.request(PicturesRequest.getPictures(page: page, perPage: perPage)) 
    }
    
    func getPicturesByQuery(queryString: String, page: Int, perPage: Int) -> Promise<PicturesResponse> {
        let networkService: PicSplashNetwork = AppDI.resolve()
        
        return networkService.request(PicturesRequest.getPicturesByQuery(queryString: queryString, page: page, perPage: perPage))
    }
}
