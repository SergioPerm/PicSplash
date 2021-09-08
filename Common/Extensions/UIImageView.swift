//
//  UIImageView.swift
//  PicSplash
//
//  Created by Sergio Lechini on 28.08.2021.
//

import UIKit

extension UIImageView {
    /// Загрузить картинку асинхронно
    /// - Parameters:
    ///   - url: адрес картинки
    ///   - completion: calback с результатом загрузки
    func asyncLoad(url: NSURL, completion: @escaping (UIImage?) -> ()) {
        return PictureLoader.publicLoader.load(url: url, completion: completion)
    }
}
