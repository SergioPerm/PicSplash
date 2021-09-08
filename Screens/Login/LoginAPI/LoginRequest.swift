//
//  LoginRequest.swift
//  PicSplash
//
//  Created by Sergio Lechini on 08.09.2021.
//

import Foundation

enum LoginRequest {
    case checkConnection(apiKey: String)
}

extension LoginRequest: HTTPRequest {
    var scheme: HTTPScheme {
        switch self {
        case .checkConnection:
            return .https
        }
    }
    
    var path: String {
        switch self {
        case .checkConnection:
            return "/v1/curated"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .checkConnection:
            return .GET
        }
    }
    
    var headers: [String : String] {
        var headers = [String:String]()
        
        headers["Accept"] = "application/json"
        
        switch self {
        case .checkConnection(let apiKey):
            headers["Authorization"] = apiKey
        }
                
        return headers
    }
    
    var parameters: [String : Any]? {
        var params = [String: Any]()
        
        params["page"] = Int(1)
        params["per_page"] = Int(10)
        
        return params
    }
}
