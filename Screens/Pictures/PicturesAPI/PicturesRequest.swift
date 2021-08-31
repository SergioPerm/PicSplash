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
        headers["Authorization"] = "563492ad6f91700001000001a47f4c0d9f054a99a392caad0f8f9c04"
        
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
