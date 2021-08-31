//
//  HTTPRequest.swift
//  PicSplash
//
//  Created by Sergio Lechini on 30.08.2021.
//

import Foundation

struct DefaultResponse<Response: Codable>: Codable {
    var response: Response?
}

enum HTTPMethod: String {
    case GET
    case PUT
    case POST
    case DELETE
}

enum HTTPScheme: String {
    case https
    case http
}

protocol HTTPRequest {
    var scheme: HTTPScheme { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String:String] { get }
    var parameters: [String:Any]? { get }
}

extension HTTPRequest {
    func urlRequest() -> URLRequest? {
        
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host   = Consts.Links.pexelBaseUrl
        components.path   = path

        if let parameters = parameters, !parameters.isEmpty {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems?.append(queryItem)
            }
        }

        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        return urlRequest
    }
}
