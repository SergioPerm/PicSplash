//
//  PictureLoader.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import UIKit

final class PictureLoader {
    static let publicLoader = PictureLoader()
}

extension PictureLoader {
    func load(url: NSURL, completion: @escaping (UIImage?) -> ()) {
                        
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 50 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: "images")
        configuration.httpMaximumConnectionsPerHost = 5
        
        let urlSession = URLSession(configuration: configuration)
        urlSession.dataTask(with: url as URL) { (data, response, error) in
            guard let responseData = data, let image = UIImage(data: responseData), error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
