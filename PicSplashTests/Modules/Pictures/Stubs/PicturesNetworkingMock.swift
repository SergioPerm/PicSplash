//
//  PicturesNetworkingMock.swift
//  PicSplashTests
//
//  Created by Sergio Lechini on 06.09.2021.
//

@testable import PicSplash
import Foundation
import Promises

class PicturesNetworkingMock {
    var pictureResponse: PicturesResponse?
}

extension PicturesNetworkingMock: PicturesNetworking {
    func getPictures(page: Int, perPage: Int) -> Promise<PicturesResponse> {
        return Promise<PicturesResponse>(on: .main) { fullFill, reject in
            if let response = self.pictureResponse {
                fullFill(response)
            } else {
                reject(PicError(title: "bad request"))
            }
        }
    }
    
    func getPicturesByQuery(queryString: String, page: Int, perPage: Int) -> Promise<PicturesResponse> {
        return Promise<PicturesResponse>(on: .main) { fullFill, reject in
            if let response = self.pictureResponse {
                fullFill(response)
            } else {
                reject(PicError(title: "bad request"))
            }
        }
    }
}
