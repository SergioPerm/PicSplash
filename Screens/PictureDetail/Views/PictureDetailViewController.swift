//
//  PictureDetailViewController.swift
//  PicSplash
//
//  Created by Sergio Lechini on 31.08.2021.
//

import UIKit
import SnapKit

/// Протокол для работы с PictureDetailViewController
protocol PictureDetailDisplayLogic: AnyObject {
    /// Показать картинку
    /// - Parameter data: данные картинки
    func showPicture(data: Data)
}

final class PictureDetailViewController: UIViewController {

    // MARK: Presenter
    var presenter: PictureDetailViewControllerOutput?
    
    // MARK: UI
    
    private let pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder")
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    // MARK: View life-cycle
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

// MARK: PictureDetailDisplayLogic
extension PictureDetailViewController: PictureDetailDisplayLogic {
    /// Показать картинку
    /// - Parameter data: данные картинки
    func showPicture(data: Data) {
        pictureImageView.image = UIImage(data: data)
    }
}
