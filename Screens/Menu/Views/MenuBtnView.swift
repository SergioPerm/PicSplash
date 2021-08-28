//
//  MenuPicturesView.swift
//  PicSplash
//
//  Created by Sergio Lechini on 23.08.2021.
//

import UIKit
import SnapKit

final class MenuBtnView: UIView {

    let shadowLayer: CAShapeLayer? = CAShapeLayer()
    
    let icon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image-gallery"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .left
        label.text = "Pictures"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        self.icon.image = image
        self.title.text = title
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadow()
    }
    
}

private extension MenuBtnView {
    func setup() {
        layer.cornerRadius = 16
        
        addSubview(icon)
        addSubview(title)
    }
    
    func setupConstraints() {
        
        icon.snp.makeConstraints({ make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.5)
        })
        
        title.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(icon.snp.bottom).offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(10).priority(.low)
        })
        
    }
    
    func updateShadow() {
        shadowLayer?.removeFromSuperlayer()
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
        
        shadowLayer?.fillColor = #colorLiteral(red: 0.9285599227, green: 0.9285599227, blue: 0.9285599227, alpha: 1).cgColor
        shadowLayer?.shadowColor = UIColor.black.cgColor
        shadowLayer?.shadowOpacity = 0.3
        shadowLayer?.shadowOffset = CGSize(width: 0.7, height: 1.5)
        shadowLayer?.shadowRadius = 3
        shadowLayer?.path = path
        shadowLayer?.shadowPath = path
        shadowLayer?.shouldRasterize = true
        shadowLayer?.rasterizationScale = UIScreen.main.scale
        
        if let shadowLayer = shadowLayer {
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
