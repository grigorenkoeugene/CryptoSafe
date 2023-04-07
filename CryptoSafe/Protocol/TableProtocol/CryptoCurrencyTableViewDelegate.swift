//
//  CryptoCurrencyTableViewDelegate.swift
//  CryptoSafe
//
//  Created by admin on 03.04.2023.
//

import Foundation

protocol CryptoCurrencyTableViewDelegate {
    func cyrrencyDetailCellViewModel(forIndexPath indexPath: IndexPath) -> CurrencyDetailViewModel?
}
