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
    func closeMenu()
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
            
    let logOutBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Logout", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        return btn
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
        view.addSubview(logOutBtn)
        
        let picturesTap = UITapGestureRecognizer(target: self, action: #selector(openPictures))
        let favoritesTap = UITapGestureRecognizer(target: self, action: #selector(openFavorites))
        picturesView.addGestureRecognizer(picturesTap)
        favoritesView.addGestureRecognizer(favoritesTap)
        
        logOutBtn.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
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
        
        logOutBtn.snp.makeConstraints({ make in
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.top.equalTo(favoritesView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        })
    }
}

//MARK: Actions
private extension MenuViewController {
    @objc func openPictures() {
        presenter?.openPictures()
    }
    
    @objc func openFavorites() {
        presenter?.openFavorites()
    }
    
    @objc func logoutAction() {
        presenter?.logout()
    }
}

extension MenuViewController: MenuDisplayLogic {
    func closeMenu() {
        navigationController?.popViewController(animated: true)
    }
}
