//
//  PicturesBottomLoaderView.swift
//  PicSplash
//
//  Created by Sergio Lechini on 30.08.2021.
//

import UIKit
import SnapKit

protocol PicturesBottomLoaderViewType {
    func show()
    func hide()
}

class PicturesBottomLoaderView: UICollectionReusableView {

    /// activityIndicator
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: Setup
private extension PicturesBottomLoaderView {
    func setup() {
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func setupConstraints() {
        activityIndicator.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(30)
            make.top.bottom.equalToSuperview()
        })
    }
}

// MARK: SearchAdsFooterLoadViewType
extension PicturesBottomLoaderView: PicturesBottomLoaderViewType {
    func show() {
        activityIndicator.isHidden = false
    }
    
    func hide() {
        activityIndicator.isHidden = true
    }
}
