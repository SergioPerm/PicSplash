//
//  FavoritesViewController.swift
//  PicSplash
//
//  Created by Sergio Lechini on 02.09.2021.
//

import UIKit

/// Протокол отображения FavoritesViewController-а
protocol FavoritesDisplayLogic: AnyObject {
    /// Полностью перезагрузить картинки
    /// - Parameter ads: viewModels картинок
    func reloadPictures(pictures: [PictureViewModelType])
    func removePicture(pictureID: Int)
}

final class FavoritesViewController: UIViewController {

    // MARK: Presenter
    var presenter: FavoritesViewControllerOutput?
        
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
private extension FavoritesViewController {
    func setup() {
        
        navigationController?.isNavigationBarHidden = false
        
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        PictureCollectionViewCell.register(collectionView)
        
        layout.sectionInset = collectionSectionInsets
        layout.minimumLineSpacing = collectionMinimumItemSpacing
        layout.minimumInteritemSpacing = collectionMinimumItemSpacing
        layout.footerReferenceSize = CGSize(width: collectionView.bounds.width, height: 30)
    }
}

// MARK: Setup
private extension FavoritesViewController {
    func setupConstraints() {
        collectionView.snp.makeConstraints({ make in
            make.left.top.bottom.right.equalToSuperview()
        })
    }
}

// MARK: PicturesDisplayLogic
extension FavoritesViewController: FavoritesDisplayLogic {
    /// Полностью перезагрузить картинки
    /// - Parameter ads: viewModels картинок
    func reloadPictures(pictures: [PictureViewModelType]) {
        viewModels = pictures
        collectionView.reloadData()
    }
    
    func removePicture(pictureID: Int) {
        if let picIndex = viewModels.firstIndex(where: { picViewModel in
            picViewModel.outputs.id == pictureID
        }) {
            collectionView.performBatchUpdates {
                viewModels.remove(at: picIndex)
                collectionView.deleteItems(at: [IndexPath(row: picIndex, section: 0)])
            } completion: { finished in
            }
        }
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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

// MARK: UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
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

