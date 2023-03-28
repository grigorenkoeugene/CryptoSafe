import UIKit

class LoginViewController: UIViewController {
    
    private var viewModel = LoginViewModel()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Write email"
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.indent(size: 10)
        textField.outdent(size: 50)
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()

    private var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Write password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.indent(size: 10)
        textField.outdent(size: 50)
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()
    
    private var imageHome: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "home")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LogIn", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(loginOnClick), for: .touchUpInside)
        return button
    }()
    
    private var newView: UIView = {
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
    
    private var imageViewEmailTextField: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        image.image = UIImage(named: "iconEmail")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var imageViewPasswordTextField: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "iconPassword")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var noneAccountlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Don't have an account yet?"
        label.alpha = 0.3
        return label
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create an account", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        let attributedString = NSAttributedString(string: "Create an account", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue,
             .underlineColor: UIColor.black])
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(createAccountOnClick), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(newView)
        self.view.addSubview(imageHome)
        viewModel = LoginViewModel()
        self.view.backgroundColor = .white
        self.view.addSubview(emailLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordLabel)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(noneAccountlabel)
        self.view.addSubview(createAccountButton)
        self.emailTextField.addSubview(imageViewEmailTextField)
        self.passwordTextField.addSubview(imageViewPasswordTextField)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        createConstraintsOnView()
    }
    
    @objc func loginOnClick() {
        if let email = emailTextField.text, let password = passwordTextField.text,
            viewModel.checkLogin(email: email, password: password)  {
            UserDefaults.standard.set(true, forKey: "authorization")
            viewModel.switchScreen(CryptoCurrencyTableViewController())
        } else {
            alertMessage(title: "Error", message: "Invalid username or password.", buttonTitle: "OK")
        }
    }
    
    @objc func createAccountOnClick() {
        alertMessage(title: "Error", message: "This feature is not available.", buttonTitle: "OK")
    }
    
    private func alertMessage(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func createConstraintsOnView() {
        NSLayoutConstraint.activate([
            
            // newView constraints
            newView.leftAnchor.constraint(equalTo: view.leftAnchor),
            newView.rightAnchor.constraint(equalTo: view.rightAnchor),
            newView.topAnchor.constraint(equalTo: view.topAnchor),
            newView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/1.4),
            
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
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 65),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -65),
            loginButton.topAnchor.constraint(equalTo: newView.bottomAnchor, constant: -25),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // noneAccountlabel constraints
            noneAccountlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noneAccountlabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 45),
            noneAccountlabel.heightAnchor.constraint(equalToConstant: 18),
            
            // createAccountButton constraints
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.topAnchor.constraint(equalTo: noneAccountlabel.bottomAnchor, constant: 20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
