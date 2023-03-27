import UIKit

class LoginViewModel: LoginViewModelType {
    func switchScreen(_ screan: UIViewController) {
        let vc = screan
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
    
    func checkLogin(email: String, password: String) -> Bool {
        return Users.logins.contains(where: { $0.login == email && $0.password == password })
    }

    
}
