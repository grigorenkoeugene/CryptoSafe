import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties

    private var coordinator = AppCoordinator()
    
    private let emailLabel = UILabel(text: "Email")
    private let passwordLabel = UILabel(text: "Password")
    
    private let emailTextField = UITextField(placeholder: "Write email")
    private let passwordTextField = UITextField(placeholder: "Write password",
                                                isSecureTextEntry: true)
    
    private let imageHome = UIImageView(named: "home")
    private let imageViewEmailTextField = UIImageView(named: "iconEmail")
    private let imageViewPasswordTextField = UIImageView(named: "iconPassword")

    private lazy var handleLoginButton = UIButton.loginButton(target: self,
                                                              action: #selector(handleLoginButtonTap))
    private lazy var createAccountButton = UIButton.createAccountButton(target: self,
                                                                        action: #selector(createAccountButtonTap))
    
    private var noneAccountlabel: UILabel = {
        let label = UILabel(text: "Don't have an account yet?")
        label.textColor = #colorLiteral(red: 0.7506795526, green: 0.7506795526, blue: 0.7506795526, alpha: 1)
        return label
    }()
    
    private var gradientView: UIView = {
        let gradientLayer = CAGradientLayer()
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.4))
        gradientLayer.frame = newView.bounds
        gradientLayer.colors = [
            UIColor(red: 0.91, green: 0.792, blue: 0.471, alpha: 1).cgColor,
            UIColor(red: 0.694, green: 0.878, blue: 0.847, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        newView.layer.insertSublayer(gradientLayer, at: 0)
        let path = UIBezierPath(
            roundedRect: newView.bounds,
            byRoundingCorners: [.bottomLeft,.bottomRight],
            cornerRadii: CGSize(width: 50, height: 50))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        newView.layer.mask = mask
        return newView
    }()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(gradientView)
        setupSubviews()
        
        coordinator = AppCoordinator()
        view.backgroundColor = .white
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        createConstraints()
    }
    
    // MARK: - Setup

    private func setupSubviews() {
        view.addSubview(imageHome)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(handleLoginButton)
        view.addSubview(noneAccountlabel)
        view.addSubview(createAccountButton)
        self.emailTextField.addSubview(imageViewEmailTextField)
        self.passwordTextField.addSubview(imageViewPasswordTextField)
    }
    
    // MARK: - Actions

    @objc func handleLoginButtonTap() {
        if let email = emailTextField.text, let password = passwordTextField.text,
           AuthManager().validate(email: email, password: password) {
            AuthManager.isAuthorized = true
            coordinator.switchScreen(.main)
        } else {
            alertMessage(title: "Error", message: "Invalid username or password.", buttonTitle: "OK")
        }
    }
    
    @objc func createAccountButtonTap() {
        alertMessage(title: "Error", message: "This feature is not available.", buttonTitle: "OK")
    }
    
    private func alertMessage(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Constraints

    private func createConstraints() {
        NSLayoutConstraint.activate([
            
            // newView constraints
            gradientView.leftAnchor.constraint(equalTo: view.leftAnchor),
            gradientView.rightAnchor.constraint(equalTo: view.rightAnchor),
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/1.4),
            
            // imageHome constraints
            imageHome.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageHome.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            
            // emailLabel constraints
            emailLabel.leftAnchor.constraint(equalTo: emailTextField.leftAnchor),
            emailLabel.rightAnchor.constraint(equalTo: emailTextField.rightAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // emailTextField constraints
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 55),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -55),
            emailTextField.topAnchor.constraint(equalTo: imageHome.bottomAnchor, constant: 30),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            // imageViewEmailTextField constraints
            imageViewEmailTextField.rightAnchor.constraint(equalTo: emailTextField.rightAnchor, constant: -20),
            imageViewEmailTextField.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            imageViewEmailTextField.widthAnchor.constraint(equalToConstant: 20),
            imageViewEmailTextField.heightAnchor.constraint(equalToConstant: 20),
            
            // passwordLabel constraints
            passwordLabel.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor),
            passwordLabel.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor),
            passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor),
            passwordLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // passwordTextField constraints
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 55),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -55),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            // imageViewPasswordTextField constraints
            imageViewPasswordTextField.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: -14),
            imageViewPasswordTextField.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            imageViewPasswordTextField.widthAnchor.constraint(equalToConstant: 30),
            imageViewPasswordTextField.heightAnchor.constraint(equalToConstant: 30),
            
            // loginButton constraints
            handleLoginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 65),
            handleLoginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -65),
            handleLoginButton.topAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -25),
            handleLoginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // noneAccountlabel constraints
            noneAccountlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noneAccountlabel.topAnchor.constraint(equalTo: handleLoginButton.bottomAnchor, constant: 45),
            noneAccountlabel.heightAnchor.constraint(equalToConstant: 18),
            
            // createAccountButton constraints
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.topAnchor.constraint(equalTo: noneAccountlabel.bottomAnchor, constant: 20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}

// MARK: - Extension

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

private extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

private extension UITextField {
    convenience init(placeholder: String, isSecureTextEntry: Bool = false) {
        self.init()
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.indent(size: 10)
        self.outdent(size: 50)
        self.keyboardType = .default
        self.returnKeyType = .done
    }
}

private extension UIImageView {
    convenience init(named: String) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(named: named)
        self.contentMode = .scaleAspectFill
    }
}

private extension UIButton {
    static func loginButton(target: Any?, action: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LogIn", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    static func createAccountButton(target: Any?, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create an account", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        let attributedString = NSAttributedString(string: "Create an account", attributes:
                                                    [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                     .underlineColor: UIColor.black])
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}



