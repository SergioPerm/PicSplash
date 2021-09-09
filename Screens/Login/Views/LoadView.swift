//
//  LoadView.swift
//  PicSplash
//
//  Created by Sergio Lechini on 09.09.2021.
//

import UIKit
import SnapKit

class LoadView: UIView {

    private let circleProgressView: CircleActivityViewType = {
        let view = CircleActivityView(colors: [.black], lineWidth: 10)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
}

private extension LoadView {
    func setup() {
        backgroundColor = .white
        addSubview(circleProgressView)
        circleProgressView.startAnimating()
        
        circleProgressView.snp.makeConstraints({ make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(80)
        })
        
    }
}
