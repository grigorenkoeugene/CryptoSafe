import Foundation

struct Users {
    let login: String
    let password: String
}

extension Users {
    static var logins = [
        Users(login: "1234", password: "1234")
    ]
}
