//
//  CryptoCurrencyTableViewDataSource.swift
//  CryptoSafe
//
//  Created by admin on 03.04.2023.
//

import Foundation

protocol CryptoCurrencyTableViewDataSource {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CryptoCurrencyTableViewCellViewModelType?
    func asset(atIndex index: Int) -> Asset?
}
