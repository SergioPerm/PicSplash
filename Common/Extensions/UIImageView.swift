//
//  UIImageView.swift
//  PicSplash
//
//  Created by Sergio Lechini on 28.08.2021.
//

import UIKit

extension UIImageView {
    func asyncLoad(url: NSURL, completion: @escaping (UIImage?) -> ()) {
        return PictureLoader.publicLoader.load(url: url, completion: completion)
    }
}
