//
//  UIView.swift
//  PicSplash
//
//  Created by Sergio Lechini on 23.08.2021.
//

import UIKit

extension UIView {
    static var globalView: UIView? {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
    }
}
