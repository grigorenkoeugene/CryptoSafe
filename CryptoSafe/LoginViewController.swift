//
//  ViewController.swift
//  CryptoSafe
//
//  Created by admin on 28.02.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Write email"
        textField.backgroundColor = .systemGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Write password"
        textField.backgroundColor = .systemGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LogIn", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(loginOnClick), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        if UserDefaults.standard.bool(forKey: "authorization") == true {
            presentMainTableViewController()
        } else {
            self.view.addSubview(emailLabel)
            self.view.addSubview(emailTextField)
            self.view.addSubview(passwordLabel)
            self.view.addSubview(passwordTextField)
            self.view.addSubview(loginButton)

            createEmailTextFieldConstraints()
            createEmailLabelConstraints()
            createPasswordTextFieldConstraints()
            createPasswordLabelConstraints()
            createLoginButtonConstraints()
        }
    }
    
    @objc func loginOnClick() {
        if emailTextField.text == "1234" && passwordTextField.text == "1234" {
            UserDefaults.standard.set(true, forKey: "authorization")
            presentMainTableViewController()
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func presentMainTableViewController() {
        let vc = MainTableViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
    private func createEmailLabelConstraints() {
        emailLabel.leftAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: emailTextField.rightAnchor).isActive = true
        emailLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func createEmailTextFieldConstraints() {
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func createPasswordLabelConstraints() {
        passwordLabel.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor).isActive = true
        passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func createPasswordTextFieldConstraints() {
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func createLoginButtonConstraints() {
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
}

