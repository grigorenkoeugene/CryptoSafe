import Foundation

struct User {
    let login: String
    let password: String
}

extension User {
    static var logins = [
        User(login: "1234", password: "1234")
    ]
}
