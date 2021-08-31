//
//  PictureDetailAPI.swift
//  PicSplash
//
//  Created by Sergio Lechini on 31.08.2021.
//

import Foundation
import Promises

struct PictureDetailAPI {
    static func loadImageData(url: String) -> Promise<Data> {
        let networkService: PicSplashNetwork = AppDI.resolve()
        
        return networkService.requestData(URL(string: url))
    }
    
}
