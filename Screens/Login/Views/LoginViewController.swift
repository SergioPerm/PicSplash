//
//  LoginViewController.swift
//  PicSplash
//
//  Created by Sergio Lechini on 08.09.2021.
//

import UIKit
import SnapKit

/// Протокол для работы с LoginViewController
protocol LoginDisplayLogic: AnyObject {
    /// Показать ошибку входа
    /// - Parameter errorDesc: описание ошибки
    func showLoginError(errorDesc: String)
}

final class LoginViewController: UIViewController {

    // MARK: Presenter
    var presenter: LoginViewControllerOutput?
    
    // MARK: UI
    let pexelsIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pexelsicon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let apiTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your API key..."
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        
        return textField
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter the key to access in Pexels.com API"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
                
        return label
    }()
    
    let loginBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("LOGIN", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.7696319265, green: 0.7692830679, blue: 0.7619793546, alpha: 1)
        btn.layer.cornerRadius = 10
        
        return btn
    }()
    
    // MARK: View life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        presenter?.checkAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: Setup
private extension LoginViewController {
    func setup() {
        view.backgroundColor = #colorLiteral(red: 0.9589239691, green: 0.9589239691, blue: 0.9589239691, alpha: 1)
        
        view.addSubview(pexelsIcon)
        view.addSubview(apiTextField)
        view.addSubview(infoLabel)
        view.addSubview(loginBtn)
        
        loginBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
}

// MARK: Setup constraints
private extension LoginViewController {
    func setupConstraints() {
        
        pexelsIcon.snp.makeConstraints({ make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(infoLabel.snp.top).offset(-30)
        })
        
        apiTextField.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
        })
        
        infoLabel.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.height.equalTo(10).priority(.low)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.bottom.equalTo(apiTextField.snp.top).offset(-100)
        })
        
        loginBtn.snp.makeConstraints({ make in
            make.width.equalTo(70)
            make.height.equalTo(apiTextField.snp.height)
            make.centerY.equalToSuperview()
            make.left.equalTo(apiTextField.snp.right).offset(20)
            make.right.equalToSuperview().offset(-10)
        })
        
    }
}

// MARK: Actions
private extension LoginViewController {
    @objc func loginAction() {
        if let apiKey = apiTextField.text {
            presenter?.login(apiKey: apiKey)
        }
    }
}

// MARK: LoginDisplayLogic
extension LoginViewController: LoginDisplayLogic {
    func showLoginError(errorDesc: String) {
        let alert = UIAlertController(title: "Error", message: errorDesc, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
