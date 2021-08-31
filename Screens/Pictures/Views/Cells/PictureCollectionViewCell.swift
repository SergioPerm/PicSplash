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
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return label
    }()
    
    private let favoriteBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "star"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        btn.layer.cornerRadius = 10
        
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
}

// MARK: Setup
private extension PictureCollectionViewCell {
    func setup() {
        contentView.addSubview(backView)
        backView.addSubview(imageView)
        backView.addSubview(favoriteBtn)
        backView.addSubview(photograperNameLabel)
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
            make.right.equalToSuperview().offset(-5)
        })
        
        favoriteBtn.snp.makeConstraints({ make in
            make.width.height.equalTo(30)
            make.top.equalToSuperview().offset(6)
            make.right.equalToSuperview().offset(-6)
        })
        
        photograperNameLabel.snp.makeConstraints({ make in
            make.top.equalTo(imageView.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(10).priority(.low)
        })
        
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
