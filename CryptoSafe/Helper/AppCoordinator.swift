
import UIKit

class AppCoordinator {
    enum State {
        case login
        case main
    }
    
    func switchScreen(_ state: State) {
        var vc: UIViewController!
        switch state {
        case .login:
            vc = LoginViewController()
        case .main:
            vc = CryptoCurrencyTableViewController()
        }
        vc.modalPresentationStyle = .fullScreen
        let navigationController = UINavigationController(rootViewController: vc)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
