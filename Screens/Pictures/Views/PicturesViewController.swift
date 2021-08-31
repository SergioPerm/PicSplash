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
    /// Добавить картинки к текущим
    /// - Parameter pictures: viewModels картинок
    func addPictures(pictures: [PictureViewModelType])
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
    
    /// SupplementaryView для футера collectionview, отображается при постраничной загрузке
    private var pageLoadView: PicturesBottomLoaderViewType?
    
    /// Refresh control для collection view
    private let refreshControl = UIRefreshControl()
    
    /// Search controller для поиска картинок
    private let searchController: UISearchController = UISearchController()
    
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
        
        navigationController?.isNavigationBarHidden = false
        
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        PictureCollectionViewCell.register(collectionView)
        collectionView.register(PicturesBottomLoaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PicturesBottomLoaderView")
        
        layout.sectionInset = collectionSectionInsets
        layout.minimumLineSpacing = collectionMinimumItemSpacing
        layout.minimumInteritemSpacing = collectionMinimumItemSpacing
        layout.footerReferenceSize = CGSize(width: collectionView.bounds.width, height: 30)
        
        //searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = true
        
        navigationItem.searchController = searchController
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

// MARK: Actions
private extension PicturesViewController {
    @objc func didPullToRefresh(_ sender: Any) {
        presenter?.loadPictures()
    }
}

// MARK: PicturesDisplayLogic
extension PicturesViewController: PicturesDisplayLogic {
    /// Полностью перезагрузить картинки
    /// - Parameter ads: viewModels картинок
    func reloadPictures(pictures: [PictureViewModelType]) {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        
        viewModels = pictures
        collectionView.reloadData()
    }
    /// Добавить картинки к текущим
    /// - Parameter pictures: viewModels картинок
    func addPictures(pictures: [PictureViewModelType]) {
        self.loadPage = false
        pageLoadView?.hide()

        collectionView.performBatchUpdates({
                        
            var newIndex = viewModels.count - 1
            if !pictures.isEmpty {
                self.viewModels.append(contentsOf: pictures)
                let insertIndexPaths = pictures.map { _ -> IndexPath in
                    newIndex += 1
                    return IndexPath(row: newIndex, section: 0)
                }
                collectionView.insertItems(at: insertIndexPaths)
            }
        }, completion: nil)
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

// MARK: UICollectionViewDataSource
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter, let loadView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PicturesBottomLoaderView", for: indexPath) as? PicturesBottomLoaderView {

            if pageLoadView == nil {
                pageLoadView = loadView
            }
            
            if !loadPage {
                pageLoadView?.hide()
            } else {
                pageLoadView?.show()
            }
            
            return loadView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !loadPage && indexPath.row == viewModels.count - 1 {
            loadPage = true

            presenter?.loadPicturesNewPage()
        }
    }
}

//MARK: UISearchBarDelegate
extension PicturesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchController.searchBar.text {
            presenter?.setQuery(queryString: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.setQuery(queryString: "")
    }
}
