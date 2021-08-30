//
//  MainScreenViewController.swift
//  PicSplash
//
//  Created by Sergio Lechini on 23.08.2021.
//

import UIKit
import SnapKit

/// Протокол отображения MenuViewController-а
protocol MenuDisplayLogic: AnyObject {
    
}

final class MenuViewController: UIViewController {

    // MARK Presenter
    var presenter: MenuViewControllerOutput?
        
    // MARK: - UI
    
    let picturesView: MenuBtnView = {
        let view = MenuBtnView(title: "Pictures", image: UIImage(named: "image-gallery"))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let favoritesView: MenuBtnView = {
        let view = MenuBtnView(title: "Favorites", image: UIImage(named: "favorite"))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
}

// MARK: Setup
private extension MenuViewController {
    func setup() {
        view.backgroundColor = #colorLiteral(red: 0.9589239691, green: 0.9589239691, blue: 0.9589239691, alpha: 1)
        
        view.addSubview(picturesView)
        view.addSubview(favoritesView)
        
        let picturesTap = UITapGestureRecognizer(target: self, action: #selector(openPictures))
        picturesView.addGestureRecognizer(picturesTap)
    }
}

// MARK: Setup constraints
private extension MenuViewController {
    func setupConstraints() {
        
        guard let globalView = UIView.globalView else { return }
        let btnSide = globalView.frame.width * 0.5
        let spacing = (globalView.frame.height - btnSide * 2)/3
        
        picturesView.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(spacing)
            make.width.height.equalTo(btnSide)
        })
        
        favoritesView.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(picturesView.snp.bottom).offset(spacing)
            make.width.height.equalTo(btnSide)
        })
        
    }
}

//MARK: Actions
private extension MenuViewController {
    @objc func openPictures() {
        presenter?.openPictures()
    }
}

extension MenuViewController: MenuDisplayLogic {
    
}
