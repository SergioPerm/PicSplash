//
//  PIctureCollectionViewCell.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import UIKit
import SnapKit

class PictureCollectionViewCell: UICollectionViewCell, CollectionViewCellType {
    
    // MARK: ViewModel
    weak var viewModel: PictureViewModelType? {
        didSet {
            bindViewModel()
        }
    }
    
    // MARK: UI
    
    private let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        return view
    }()
    
    private let gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = .init(x: 0.5, y: 0.5)
        gradient.endPoint = .init(x: 0.5, y: 1.0)
        gradient.colors = [UIColor.clear.cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5039328231).cgColor]
        
        return gradient
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = .darkGray
        
        return imageView
    }()
    
    private let photograperNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .white
        
        return label
    }()
    
    private let favoriteBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "star"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .white
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = gradientView.bounds
    }
}

// MARK: Setup
private extension PictureCollectionViewCell {
    func setup() {
        
        gradientView.layer.addSublayer(gradient)
        imageView.addSubview(gradientView)
        imageView.bringSubviewToFront(gradientView)
        
        contentView.addSubview(backView)
        backView.addSubview(imageView)
        backView.addSubview(favoriteBtn)
        backView.addSubview(photograperNameLabel)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(openPicture))
        contentView.addGestureRecognizer(tapRecognizer)
    }
}

// MARK: Setup contraints
private extension PictureCollectionViewCell {
    func setupConstraints() {
        
        backView.snp.makeConstraints({ make in
            make.left.top.bottom.right.equalToSuperview()
        })
        
        imageView.snp.makeConstraints({ make in
            make.left.top.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
        })
        
        gradientView.snp.makeConstraints({ make in
            make.left.top.right.bottom.equalToSuperview()
        })
        
        favoriteBtn.snp.makeConstraints({ make in
            make.width.height.equalTo(30)
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        })
        
        photograperNameLabel.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(14).priority(.low)
        })
        
    }
}

// MARK: Actions
private extension PictureCollectionViewCell {
    @objc func openPicture() {
        viewModel?.inputs.openPicture()
    }
}

// MARK: Bind viewModel
private extension PictureCollectionViewCell {
    func bindViewModel() {
        guard let viewModel = viewModel, let imageURL = NSURL(string: viewModel.outputs.imageUrl) else { return }
  
        imageView.contentMode = .center
        imageView.image = UIImage(named: "placeholder")
        imageView.asyncLoad(url: imageURL) { [weak self] image in
            guard let `self` = self else { return }
            self.imageView.contentMode = .scaleAspectFill
            self.imageView.image = image
        }
        
        photograperNameLabel.text = viewModel.outputs.photographerName
        backView.backgroundColor = UIColor(hexString: viewModel.outputs.avgColorHex)
    }
}
