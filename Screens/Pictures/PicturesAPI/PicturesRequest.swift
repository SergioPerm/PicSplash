//
//  PicturesRequest.swift
//  PicSplash
//
//  Created by Sergio Lechini on 30.08.2021.
//

import Foundation

enum PicturesRequest {
    case getPictures(page: Int, perPage: Int)
    case getPicturesByQuery(queryString: String, page: Int, perPage: Int)
}

extension PicturesRequest: HTTPRequest {
    var scheme: HTTPScheme {
        switch self {
        case .getPictures, .getPicturesByQuery:
            return .https
        }
    }
    
    var path: String {
        switch self {
        case .getPictures:
            return "/v1/curated"
        case .getPicturesByQuery:
            return "/v1/search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPictures, .getPicturesByQuery:
            return .GET
        }
    }
    
    var headers: [String : String] {
        var headers = [String:String]()
        
        headers["Accept"] = "application/json"
        
        //Плохое решение, сервис локатор
        let keyChainstore: KeyChainStore = AppDI.resolve()
        
        headers["Authorization"] = keyChainstore.getApiKey(for: Consts.Links.pexelBaseUrl)
                
        return headers
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getPictures(let page, let perPage):
            var params = [String: Any]()
            
            params["page"] = page
            params["per_page"] = perPage
            
            return params
        case .getPicturesByQuery(let queryString, let page, let perPage):
            var params = [String: Any]()
            
            params["query"] = queryString
            params["page"] = page
            params["per_page"] = perPage
            
            return params
        }
    }
}
