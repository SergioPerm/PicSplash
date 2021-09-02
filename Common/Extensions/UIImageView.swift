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
    
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }
    
    @objc private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}
