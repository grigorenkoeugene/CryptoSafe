import Foundation

struct User: LoginViewModelType {    
    let login: String
    let password: String
}

class AuthManager {
    private enum Key {
        static let authorization = "authorization"
    }
    
    private var admin = User(login: "1234", password: "1234")
    
    static var isAuthorized: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: Key.authorization)
        }
        get {
            UserDefaults.standard.bool(forKey: Key.authorization)
        }
    }
    func validate(email: String, password: String) -> Bool {
        admin.login == email && admin.password == password
    }
}
