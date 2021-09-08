//
//  PicturesBottomLoaderView.swift
//  PicSplash
//
//  Created by Sergio Lechini on 30.08.2021.
//

import UIKit
import SnapKit

/// Протокол для работы PicturesBottomLoaderView
protocol PicturesBottomLoaderViewType {
    /// Показать
    func show()
    /// Спрятать
    func hide()
}

final class PicturesBottomLoaderView: UICollectionReusableView {

    /// activityIndicator
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    // MARK: Init
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

// MARK: PicturesBottomLoaderViewType
extension PicturesBottomLoaderView: PicturesBottomLoaderViewType {
    func show() {
        activityIndicator.isHidden = false
    }
    
    func hide() {
        activityIndicator.isHidden = true
    }
}
