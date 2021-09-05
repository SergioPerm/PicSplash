//
//  PicturesAPI.swift
//  PicSplash
//
//  Created by Sergio Lechini on 28.08.2021.
//

import Foundation
import Promises

struct PicError: LocalizedError {
    var title: String?
    
    var localizedDescription: String {
        return title ?? "Unrecognize error"
    }
}

final class PicSplashNetwork {
    
    private let urlSession: URLSession = {
        let session = URLSession(configuration: .default)
        
        return session
    }()
    
    func request<Response: Codable>(_ request: HTTPRequest) -> Promise<Response> {
        let promise = Promise<Response>(on: .main) { fullFill, reject in
            guard let urlRequest = request.urlRequest() else {
                reject(PicError(title: "Bad request object"))
                return
            }
            
            self.urlSession.dataTask(with: urlRequest) { (data, response, error) in
                guard let responseData = data, error == nil else {
                    if let error = error {
                        reject(error)
                    } else {
                        reject(PicError(title: "bad data"))
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(Response.self, from: responseData)
                    fullFill(response)
                } catch {
                    reject(error)
                }
            }.resume()
        }
        
        return promise
    }
    
    func requestData(_ url: URL?) -> Promise<Data> {
        let promise = Promise<Data>(on: .main) { fullFill, reject in
            guard let url = url else {
                reject(PicError(title: "wrong url"))
                return
            }
            
            self.urlSession.dataTask(with: url) { (data, response, error) in
                guard let responseData = data, error == nil else {
                    if let error = error {
                        reject(error)
                    } else {
                        reject(PicError(title: "bad data"))
                    }
                    return
                }
                
                fullFill(responseData)
            }.resume()
        }
        
        return promise
    }
}
