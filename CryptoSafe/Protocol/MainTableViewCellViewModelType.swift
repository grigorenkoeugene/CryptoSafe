//
//  MainTableViewCellViewModelType.swift
//  CryptoSafe
//
//  Created by admin on 27.03.2023.
//

import Foundation

protocol MainTableViewCellViewModelType: AnyObject {
    var name: String { get }
    var price: String { get }
    func formatPrice(_ price: String?) -> String
}
