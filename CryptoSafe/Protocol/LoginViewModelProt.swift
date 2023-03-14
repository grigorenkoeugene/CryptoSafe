import UIKit

protocol LoginViewModelProt {
    func checkLogin(email: String, password: String) -> Bool
    func switchScreen(_ screan: UIViewController)
}
