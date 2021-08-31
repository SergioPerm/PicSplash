//
//  PictureDetailViewController.swift
//  PicSplash
//
//  Created by Sergio Lechini on 31.08.2021.
//

import UIKit
import SnapKit

/// Протокол отображения MenuViewController-а
protocol PictureDetailDisplayLogic: AnyObject {
    func showPicture(data: Data)
}

final class PictureDetailViewController: UIViewController {

    // MARK: Presenter
    var presenter: PictureDetailViewControllerOutput?
    
    // MARK: UI
    
    private let pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder")
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        presenter?.loadImage()
    }
    
}

// MARK: Setup
private extension PictureDetailViewController {
    func setup() {
        view.backgroundColor = .white
        view.addSubview(pictureImageView)
    }
}

// MARK: Setup constraints
private extension PictureDetailViewController {
    func setupConstraints() {
        pictureImageView.snp.makeConstraints({ make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
}

extension PictureDetailViewController: PictureDetailDisplayLogic {
    func showPicture(data: Data) {
        pictureImageView.image = UIImage(data: data)
    }
}
