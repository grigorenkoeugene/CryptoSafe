import Foundation

struct User {
    let login: String
    let password: String
}

class AuthManager {
    private var admin = User(login: "1234", password: "1234")
    
    static var isAuthorized: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "authorization")
        }
        get {
            UserDefaults.standard.bool(forKey: "authorization")
        }
    }
    func validate(email: String, password: String) -> Bool {
        admin.login == email && admin.password == password
    }
}
