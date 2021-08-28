//
//  PicturesViewController.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import UIKit
import SnapKit

/// Протокол отображения MenuViewController-а
protocol PicturesDisplayLogic: AnyObject {
    /// Полностью перезагрузить картинки
    /// - Parameter ads: viewModels картинок
    func reloadPictures(pictures: [PictureViewModelType])
}

class PicturesViewController: UIViewController {

    // MARK: Presenter
    var presenter: PicturesViewControllerOutput?
        
    
    // MARK: UI
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    // MARK: CollectionView config
    private let collectionItemsPerRowIn: CGFloat = 2.0
    private let collectionMinimumItemSpacing: CGFloat = 4.0
    private let collectionSectionInsets: UIEdgeInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
    
    /// Refresh control для collection view
    private let refreshControl = UIRefreshControl()
    
    /// Признак процесса загрузки страницы
    private var loadPage: Bool = false
        
    // MARK: ViewModels
    private var viewModels: [PictureViewModelType] = []
    
    // MARK: View life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        presenter?.loadPictures()
    }

}

// MARK: Setup
private extension PicturesViewController {
    func setup() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        collectionView.register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: PictureCollectionViewCell.identifier)
        
        layout.sectionInset = collectionSectionInsets
        layout.minimumLineSpacing = collectionMinimumItemSpacing
        layout.minimumInteritemSpacing = collectionMinimumItemSpacing
        //layout.footerReferenceSize = CGSize(width: collectionView.bounds.width, height: 30)
    }
}

// MARK: Setup
private extension PicturesViewController {
    func setupConstraints() {
        collectionView.snp.makeConstraints({ make in
            make.left.top.bottom.right.equalToSuperview()
        })
    }
}

// MARK: PicturesDisplayLogic
extension PicturesViewController: PicturesDisplayLogic {
    /// Полностью перезагрузить картинки
    /// - Parameter ads: viewModels картинок
    func reloadPictures(pictures: [PictureViewModelType]) {
        viewModels = pictures
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension PicturesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModels[indexPath.row].inputs.openPicture()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = collectionSectionInsets.left + collectionSectionInsets.right + collectionMinimumItemSpacing * (collectionItemsPerRowIn - 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / collectionItemsPerRowIn

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

extension PicturesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCollectionViewCell.identifier, for: indexPath) as? PictureCollectionViewCell {
            cell.viewModel = viewModels[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
}
