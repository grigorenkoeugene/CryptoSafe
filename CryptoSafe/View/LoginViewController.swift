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
        
        self.emailTextField.addSubview(imageViewEmailTextField)
        self.passwordTextField.addSubview(imageViewPasswordTextField)
        
        createImageHomeConstraints()
        createEmailTextFieldConstraints()
        createEmailLabelConstraints()
        createPasswordTextFieldConstraints()
        createPasswordLabelConstraints()
        createLoginButtonConstraints()
        createImageEmailTextFieldConstraints()
        createImagePasswordTextFieldConstraints()
    }
    
    @objc func loginOnClick() {
        if let email = emailTextField.text, let password = passwordTextField.text,
            viewModel.checkLogin(email: email, password: password)  {
            UserDefaults.standard.set(true, forKey: "authorization")
            viewModel.switchScreen(MainTableViewController())
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func createEmailLabelConstraints() {
        emailLabel.leftAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: emailTextField.rightAnchor).isActive = true
        emailLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func createEmailTextFieldConstraints() {
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 55).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -55).isActive = true
        emailTextField.topAnchor.constraint(equalTo: imageHome.bottomAnchor, constant: 30).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func createPasswordLabelConstraints() {
        passwordLabel.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor).isActive = true
        passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func createPasswordTextFieldConstraints() {
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 55).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -55).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func createLoginButtonConstraints() {
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 65).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -65).isActive = true
        loginButton.topAnchor.constraint(equalTo: newView.bottomAnchor, constant: -25).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func createNewViewConstraints() {
        NSLayoutConstraint.activate([
            newView.leftAnchor.constraint(equalTo: view.leftAnchor),
            newView.rightAnchor.constraint(equalTo: view.rightAnchor),
            newView.topAnchor.constraint(equalTo: view.topAnchor),
            newView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/1.4)
        ])
    }

    
    private func createImageHomeConstraints() {
        imageHome.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageHome.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
    }
    
    private func createImageEmailTextFieldConstraints() {
        imageViewEmailTextField.rightAnchor.constraint(equalTo: emailTextField.rightAnchor, constant: -20).isActive = true
        imageViewEmailTextField.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        imageViewEmailTextField.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageViewEmailTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true

    }
    
    private func createImagePasswordTextFieldConstraints() {
        imageViewPasswordTextField.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: -14).isActive = true
        imageViewPasswordTextField.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor).isActive = true
        imageViewPasswordTextField.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageViewPasswordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
    
}

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}
