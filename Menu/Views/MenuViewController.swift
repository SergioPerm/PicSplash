//
//  MainScreenViewController.swift
//  PicSplash
//
//  Created by Sergio Lechini on 23.08.2021.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {

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
    
}

// MARK: Setup
private extension MenuViewController {
    func setup() {
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = #colorLiteral(red: 0.9589239691, green: 0.9589239691, blue: 0.9589239691, alpha: 1)
        
        view.addSubview(picturesView)
        view.addSubview(favoritesView)
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
