//
//  PictureLoader.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import UIKit

final class PictureLoader {
    
    static let publicLoader = PictureLoader()
    
    private let chachedImages = NSCache<NSURL, UIImage>()
    private var requestsInProgress = [NSURL: [(UIImage?) -> ()]]()
        
}

extension PictureLoader {
    private func cachedImage(url: NSURL) -> UIImage? {
        return chachedImages.object(forKey: url)
    }
    
    func load(url: NSURL, completion: @escaping (UIImage?) -> ()) {
        
        if let image = cachedImage(url: url) {
            DispatchQueue.main.async {
                completion(image)
            }
            return
        }
        
        if let _ = requestsInProgress[url] {
            requestsInProgress[url]?.append(completion)
        } else {
            requestsInProgress[url] = [completion]
        }
        
        let urlSession = URLSession(configuration: .ephemeral)
        urlSession.dataTask(with: url as URL) { (data, response, error) in
            guard let responseData = data, let image = UIImage(data: responseData), let callbacks = self.requestsInProgress[url], error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            self.chachedImages.setObject(image, forKey: url, cost: responseData.count)
            
            for callback in callbacks {
                DispatchQueue.main.async {
                    callback(image)
                }
            }
            
        }.resume()
    }
}
