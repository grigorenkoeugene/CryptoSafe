import UIKit

protocol LoginViewModelType {
    func checkLogin(email: String, password: String) -> Bool
    func switchScreen(_ screan: UIViewController)
}
