//
//  LoginViewModel.swift
//  CryptoSafe
//
//  Created by admin on 12.03.2023.
//

import UIKit

protocol LoginViewModelProt {
    func checkLogin(email: String, password: String) -> Bool
    func switchScreen(_ screan: UIViewController)
}
