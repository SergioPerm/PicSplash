//
//  UIColor.swift
//  PicSplash
//
//  Created by Sergio Lechini on 28.08.2021.
//

import UIKit

extension UIColor {
    /// Удобный инициализатор с указанием цвета в HEX
    /// - Parameters:
    ///   - hexString: цвет в HEX
    ///   - alpha: значение альфа канала
    convenience init(hexString: String, alpha: CGFloat = 1.0) {

        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
        
    }
}
